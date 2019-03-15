from .base import Base
import glob
import itertools
import os


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'git_detail'
        self.kind = 'git_detail'

    def on_init(self, context):
        pass

    def on_close(self, context):
        pass

    def gather_candidates(self, context):
        params = ['~'] if len(context['args']) == 0 else context['args']
        # git diff-tree --no-commit-id --name-only -r 6d92611
        cmd = "git show --pretty='' --name-only {}".format(params[0])
        return [
            {'word': 'file'}
        ]
