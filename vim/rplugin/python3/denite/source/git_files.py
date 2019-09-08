import random
from denite.source.base import Base
from denite import util, process


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'my/git/all'
        self.kind = 'file'

    def on_init(self, context):
        context['__proc'] = None

    def on_close(self, context):
        if context['__proc']:
            context['__proc'].kill()
            context['__proc'] = None

    def gather_candidates(self, context):
        args = ['git', 'ls-files', '--cached', '--others', '--exclude-standard']
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
        for out in outs:
            candidates.append({
                'word': out,
                'kind': 'file',
                'action__path': util.abspath(self.vim, out),
            })
        return candidates
