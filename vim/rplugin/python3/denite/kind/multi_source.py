from denite.kind.base import Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'multi_source'
        self.default_action = 'start'

    def action_start(self, context):
        sources = []
        for target in context['targets']:
            for action_source in target['action__sources']:
                sources.append({
                    'name': action_source[0],
                    'args': action_source[1:],
                })
        context['sources_queue'].append(sources)
