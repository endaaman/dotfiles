from .base import Base


class Kind(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'git_log'
        self.default_action = 'select'

    def action_select(self, context):
        context['sources_queue'].append([{
            'name': 'git_detail',
            'args': x['action__source'][1:]
        } for x in context['targets']])
