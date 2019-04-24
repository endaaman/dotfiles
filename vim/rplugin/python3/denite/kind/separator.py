from denite.kind.base import Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'my/separator'
        self.default_action = 'nop'
        self.persist_actions += ['nop']

    def action_nop(self, context):
        pass
