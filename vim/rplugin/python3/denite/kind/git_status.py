from denite.kind.file import Kind as Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'my/git/status'
        self.redraw_actions += ['stage', 'vsplit']
        self.persist_actions += ['stage', 'vsplit']

    def action_vsplit(self, context):
        return self.action_stage(context)

    def action_open_and_move(self, context):
        v = self.action_open(context)
        self.vim.command("GitGutterNextHunk")
        return v

    def action_stage(self, context):
        for target in context['targets']:
            path = target['action__path']
            if target['action__type'] is 0: # staged
              self.vim.command('silent !git reset HEAD {}'.format(path))
            else: # not staged/Untracked
              self.vim.command('silent !git add {}'.format(path))
        # context['sources_queue'].append([{
        #     'name': 'my/git/status',
        #     'args': ''
        # }])
