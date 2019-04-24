from denite.source.base import Base
from denite import util, process


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'hoge'
        self.kind = 'file'

    def on_init(self, context):
        context['__proc'] = None

    def on_close(self, context):
        if context['__proc']:
            context['__proc'].kill()
            context['__proc'] = None

    def gather_candidates(self, context):
        args = ['echo', str(context['args'])]
        # args = ['ls', '-l'] # cwdはどこ？
        context['__proc'] = process.Process(args, context, context['path'])
        outs, errs = context['__proc'].communicate(timeout=1)
        if errs:
            return [{ 'word': x, } for x in errs]
        context['is_async'] = not context['__proc'].eof()
        if context['__proc'].eof():
            context['__proc'] = None
        return [{
                'word': x,
                'action__path': util.abspath(self.vim, x),
            } for x in outs]
