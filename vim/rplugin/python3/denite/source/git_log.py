from .base import Base
import glob
import itertools
import os


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'git_log'
        self.kind = 'git_log'

    def on_init(self, context):
        pass

    def on_close(self, context):
        pass

    def gather_candidates(self, context):
        cmd = "git log --no-merges --date=short --pretty='format:%h %cd %an %s'"
        params = ['~'] if len(context['args']) == 0 else context['args']
        items = [
            'b99d8f7 2018-11-06 endaaman update',
            ]
        return [{
            'word': x,
            'action__path': join(directory, x),
        } for x in items]
