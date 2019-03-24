from ..base import Base
from denite import util, process


GITSHOW_HIGHLIGHT_SYNTAX = [
    {'name': 'Plus',  'link': 'Question',   're': r'\(\s\|(\)+\+'},
    {'name': 'Minus', 'link': 'Error', 're': r'(\?\zs-\+\ze'},
]

class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'git/show'
        self.kind = 'file'

    def on_init(self, context):
        context['__proc'] = None

    def on_close(self, context):
        if context['__proc']:
            context['__proc'].kill()
            context['__proc'] = None

    def highlight(self):
        for syn in GITSHOW_HIGHLIGHT_SYNTAX:
            self.vim.command(
                'syntax match {0}_{1} /{2}/ contained containedin={0}'.format(self.syntax_name, syn['name'], syn['re']))
            self.vim.command(
                'highlight default link {}_{} {}'.format(self.syntax_name, syn['name'], syn['link']))

    def gather_candidates(self, context):
        if len(context['args']) == 0:
            return ['None']
        args = ['git', 'show',  '--pretty=format:', '--stat', context['args'][0]]
        context['__proc'] = process.Process(args, context, context['path'])
        return self._async_gather_candidates(context, 0.5)

    def _async_gather_candidates(self, context, timeout):
        outs, errs = context['__proc'].communicate(timeout=timeout)
        if errs:
            return [{ 'word': x, } for x in errs]
        context['is_async'] = not context['__proc'].eof()
        if context['__proc'].eof():
            context['__proc'] = None

        candidates = []
        for out in outs[:-1]:
            splitted = out.split(' ')
            # i = next((i for i, x in enumerate(splitted) if x), None)
            candidates.append({
                'word': out[1:],
                'kind': 'file',
                'action__path': util.abspath(self.vim, splitted[1]),
            })
        candidates.append({
            'word': outs[-1],
            'kind': 'word',
        })
        return candidates
