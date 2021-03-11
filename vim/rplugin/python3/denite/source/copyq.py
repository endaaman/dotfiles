import subprocess
from denite.source.base import Base
from denite import util, process

count = 20

class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'my/copyq'
        self.kind = 'word'

    def cb(self):
        self.vim.command('echom')

    def gather_candidates(self, context):
        candidates = []
        errs = []
        for i in range(count):
            r = subprocess.Popen(f'copyq tab clipboard read {i}', shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
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
