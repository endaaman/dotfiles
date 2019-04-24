from denite.source.base import Base
from denite import util, process


GITLOG_HIGHLIGHT_SYNTAX = [
    {'name': 'Name',      'link': 'Number',    're': r'\S\+\%(\s\+\d\{4\}-\)\@='},
    {'name': 'Date',      'link': 'Statement', 're': r'\d\{4\}-\d\{2\}-\d\{2\}'},
    {'name': 'Committer', 'link': 'Question',  're': r'\%(-\d\{2\}\s\)\@<=\S\+\s'},
    # {'name': 'Special1',  'link': 'Directory', 're': r'Staged '},
    # {'name': 'Special2',  'link': 'Directory', 're': r' Modified '},
    # {'name': 'Special3',  'link': 'Directory', 're': r' Untracked'},
]


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'my/git/log'
        self.kind = 'source'

    def on_init(self, context):
        context['__proc'] = None

    def on_close(self, context):
        if context['__proc']:
            context['__proc'].kill()
            context['__proc'] = None

    def highlight(self):
        for syn in GITLOG_HIGHLIGHT_SYNTAX:
            self.vim.command(
                'syntax match {0}_{1} /{2}/ contained containedin={0}'.format(self.syntax_name, syn['name'], syn['re']))
            self.vim.command(
                'highlight default link {}_{} {}'.format(self.syntax_name, syn['name'], syn['link']))

    def gather_candidates(self, context):
        args = ['git', 'log',  '--no-merges', '--date=short', '--pretty=format:%h %cd %an %s']
        context['__proc'] = process.Process(args, context, context['path'])
        return self._async_gather_candidates(context, 0.5)

    def _async_gather_candidates(self, context, timeout):
        outs, errs = context['__proc'].communicate(timeout=timeout)
        if errs:
            return [ { 'word': x, } for x in errs]
        context['is_async'] = not context['__proc'].eof()
        if context['__proc'].eof():
            context['__proc'] = None

        candidates = []
        # candidates.append({
        #     'word': 'Staged + Modified + Untracked',
        #     'kind': 'multi_source',
        #     'action__sources': [['git/staged'], ['git/modified'], ['git/untracked'], ],
        # })
        for out in outs:
            splitted = out.split(' ')
            candidates.append({
                'word': out,
                'action__source': ['my/git/show', splitted[0]],
            })
        return candidates
