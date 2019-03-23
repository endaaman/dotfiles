from .base import Base
import glob
import itertools
import os
from denite import util, process


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'git_show'
        self.kind = 'file'
        self.default_action = 'open'

    def on_init(self, context):
        pass

    def on_close(self, context):
        pass

    def gather_candidates(self, context):
        if len(context['args']) == 0:
            return ['None']
        args = ['git', 'show',  '--pretty=format:', '--name-only', context['args'][0]]
        context['__proc'] = process.Process(args, context, context['path'])
        return self._async_gather_candidates(context, 0.5)

    def _async_gather_candidates(self, context, timeout):
        outs, errs = context['__proc'].communicate(timeout=timeout)
        if errs:
            return [
                {
                    'word': x,
                }
            for x in errs]
        context['is_async'] = not context['__proc'].eof()
        if context['__proc'].eof():
            context['__proc'] = None

        candidates = [
            {
                'word': x,
                'action__path': util.abspath(self.vim, x),
            }
        for x in outs]
        return candidates
