import re
from denite.base.source import Base


REGISTER_HIGHLIGHT_SYNTAX = [
    {'name': 'Register', 'link': 'Question', 're': '\[\zs\S\ze\]\s'},
]

class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'my/register'
        self.kind = 'word'

    def highlight(self):
        for syn in REGISTER_HIGHLIGHT_SYNTAX:
            self.vim.command(
                'syntax match {0}_{1} /{2}/ contained containedin={0}'.format(self.syntax_name, syn['name'], syn['re']))
            self.vim.command(
                'highlight default link {}_{} {}'.format(self.syntax_name, syn['name'], syn['link']))

    def gather_candidates(self, context):
        candidates = []
        regs = (['+', '*'] if self.vim.call('has', 'clipboard') else []) + [
                '"',
                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
                # 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
                # 'u', 'v',
                'w', 'x', 'y', 'z',
                '-', '.', ':', '#', '%', '/', '=',
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ]
        for reg in regs:
            register = self.vim.call('getreg', reg, 1)
            if not register:
                continue

            text = re.sub(r'\n', r'\\n', register)
            candidates.append({
                'word': text,
                'abbr': '[{0}] {1}'.format(reg, text[:200]),
                'action__text': register,
            })
        return candidates
