import shutil
import subprocess
from denite.source.base import Base
from denite import util, process

count = 10

class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'my/clipboard'
        self.kind = 'word'

    def cb(self):
        self.vim.command('echom')

    def gather_candidates(self, context):
        candidates = []
        errs = []
        if shutil.which('copyq'):
            cmd_base = 'copyq tab clipboard read {}'
        else:
            cmd_base = 'qdbus org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardHistoryItem {}'

        for i in range(count):
            r = subprocess.Popen(cmd_base.format(i), shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
            stderr = r.stderr.read()
            if stderr != '':
                return [ { 'word': stderr, }]

            word = r.stdout.read()
            if word != '':
                candidates.append({
                    'word': word,
                    'abbr': f'[{i}] {word}',
                    'action__text': word,
                })

        return candidates
