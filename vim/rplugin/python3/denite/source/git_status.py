from functools import cmp_to_key
from denite.source.base import Base
from denite import util, process


ICON_MODIFIED = ''
ICON_ADDED = ''
ICON_DELETED = '✖'
ICON_RENAMED = '➜'
ICON_UNTRACKED = ''
ICON_UNKNOWN = ''

LABEL_MODIFIED  = '  Modifid    '
LABEL_STAGED    = '  Staged     '
LABEL_UNTRACKED = '  Untracked  '

GITCHANGED_HIGHLIGHT_SYNTAX = [
    {'name': 'IModified',  'link': 'Title',     're': ICON_MODIFIED },
    {'name': 'IStaged',    'link': 'Question',  're': ICON_ADDED },
    {'name': 'IDeleted',   'link': 'Error',     're': ICON_DELETED },
    {'name': 'IRenamed',   'link': 'Number',    're': ICON_RENAMED },
    {'name': 'IUntracked', 'link': 'Directory', 're': ICON_UNTRACKED },
    {'name': 'LModified',  'link': 'Comment',   're': r'.\+' + LABEL_MODIFIED + r'.\+' },
    {'name': 'LStaged',    'link': 'Comment',   're': r'.\+' + LABEL_STAGED + r'.\+' },
    {'name': 'LUntracked', 'link': 'Comment',   're': r'.\+' + LABEL_UNTRACKED + r'.\+' },
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
            # marks is like ` M` or `A `
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
                    'icon': icons.get(mark) or ICON_UNKNOWN,
                    })
        for ii in iii:
            ii.sort(key=lambda x:x['path'])
        last_type = 0
        candidates = []
        TYPE_STAGED = 0
        TYPE_MODIFIED = 1
        TYPE_UNTRACKED = 2
        orders = [TYPE_MODIFIED, TYPE_STAGED, TYPE_UNTRACKED]
        for i, _type in enumerate(orders):
            ii = iii[_type]
            if i > 0:
                candidates.append({
                    'word': '',
                    'abbr': self._get_separator(_type),
                    'kind': 'my/separator',
                    })
            for i in ii:
                candidates.append({
                    'word': '{} {}'.format(i['icon'], i['label']),
                    'action__type': _type,
                    'action__path': util.abspath(self.vim, i['path']),
                    })
        return candidates


    def _get_separator(self, _type):
        label = [LABEL_STAGED, LABEL_MODIFIED, LABEL_UNTRACKED][_type]
        w = self.vim.eval('winwidth(0)')
        lpad = (w - len(label)) // 2
        rpad = w - len(label) - lpad
        C = '-'
        return C * lpad + label + C * rpad
