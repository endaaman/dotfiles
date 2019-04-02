from functools import cmp_to_key
from denite.base.source import Base
from denite import util, process


ICON_MODIFIED = ''
ICON_ADDED = ''
ICON_DELETED = '✖'
ICON_RENAMED = '➜'
ICON_UNTRACKED = ''

NOT_STAGED_LABEL = '  Not staged  '
UNTRACKED_LABEL =  '  Untracked   '

GITCHANGED_HIGHLIGHT_SYNTAX = [
    {'name': 'IModified',  'link': 'Title',     're': ICON_MODIFIED },
    {'name': 'IStaged',    'link': 'Question',  're': ICON_ADDED },
    {'name': 'IDeleted',   'link': 'Error',     're': ICON_DELETED },
    {'name': 'IRenamed',   'link': 'Number',    're': ICON_RENAMED },
    {'name': 'IUntracked', 'link': 'Directory', 're': ICON_UNTRACKED },
    {'name': 'LNotStaged', 'link': 'Comment',   're': r'.\+' + NOT_STAGED_LABEL + r'.\+' },
    {'name': 'LUntracked', 'link': 'Comment',   're': r'.\+' + UNTRACKED_LABEL + r'.\+' },
]


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'my/git/status'
        self.kind = 'my/git/status'

    def on_init(self, context):
        context['__proc'] = None

    def on_close(self, context):
        if context['__proc']:
            context['__proc'].kill()
            context['__proc'] = None

    def highlight(self):
        for syn in GITCHANGED_HIGHLIGHT_SYNTAX:
            self.vim.command(
                'syntax match {0}_{1} /{2}/ contained containedin={0}'.format(self.syntax_name, syn['name'], syn['re']))
            self.vim.command(
                'highlight default link {}_{} {}'.format(self.syntax_name, syn['name'], syn['link']))

    def gather_candidates(self, context):
        args = ['git', 'status',  '--short']
        context['__proc'] = process.Process(args, context, context['path'])
        return self._async_gather_candidates(context, 0.5)

    def _async_gather_candidates(self, context, timeout):
        outs, errs = context['__proc'].communicate(timeout=timeout)
        if errs:
            return [ { 'word': x, } for x in errs]
        context['is_async'] = not context['__proc'].eof()
        if context['__proc'].eof():
            context['__proc'] = None
        icons = {
            'M': ICON_MODIFIED,
            'R': ICON_RENAMED,
            'A': ICON_ADDED,
            'D': ICON_DELETED,
            '??': ICON_UNTRACKED,
        }
        iii = [[], [], []]
        for out in outs:
            content = out[3:]
            marks = out[:2]
            for i, mark in enumerate(marks):
                if mark == ' ':
                    continue
                if mark == '?':
                    if i is 1:
                        _type = 2
                    else:
                        continue
                else:
                    _type = i
                if content.find('->') > -1:
                    names = content.split(' -> ')
                    path = names[-1]
                    label = ' → '.join(names)
                else:
                    path = content
                    label = content
                iii[_type].append({
                    'path': path,
                    'label': label,
                    'icon': icons.get(mark) or '',
                    })
        for ii in iii:
            ii.sort(key=lambda x:x['path'])
        last_type = 0
        candidates = []
        for _type, ii in enumerate(iii):
            if _type > 0:
                candidates.append({ 'word': '', 'abbr': self._get_separator(_type), 'kind': 'word' })
            for i in ii:
                candidates.append({
                    'word': '{} {}'.format(i['icon'], i['label']),
                    'action__type': _type,
                    'action__path': util.abspath(self.vim, i['path']),
                    })
        return candidates

    def _get_separator(self, _type):
        label = NOT_STAGED_LABEL if _type is 1 else UNTRACKED_LABEL
        w = self.vim.eval('winwidth(0)')
        lpad = (w - len(label)) // 2
        rpad = w - len(label) - lpad
        C = '-'
        return C * lpad + label + C * rpad

