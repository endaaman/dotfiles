from denite.kind.base import Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'hoge'
        self.default_action = 'piyo'

    def action_piyo(self, context):
        for target in context['targets']:
            self.vim.command('call append(line("."), "{}")'.format(target['word']))

    def action_fuga(self, context):
        for k, v in context.items():
            self.vim.command('call append(line("."), "{}: {}")'.format(k, str(v)))

    def action_back(self, context):
        last_source = context['sources'][-1]
        if not last_source:
            return # leave mode
        sources.append(last_source.copy())
