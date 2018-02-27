# coding=utf-8
import vim
import re
from enum import Enum
from operator import add
from functools import reduce


class CaseType(Enum):
    OTHER = 4545
    SNAKE = 1
    KEBAB = 2
    CAMEL = 3
    PASCAL = 4

    def next(self):
        v = self.value + 1
        if v > CaseType.PASCAL.value:
            return CaseType.SNAKE
        return CaseType(v)

    def prev(self):
        v = self.value - 1
        if v < CaseType.SNAKE.value:
            return CaseType.PASCAL
        return CaseType(v)

def is_kebab_active() -> bool:
    splitters = vim.eval('&iskeyword').split(',')
    return '-' in splitters

def flatten(l: list) -> list:
    return reduce(add, l)

def split_by_case(word: str) -> list:
    matches = re.finditer('.+?(?:(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])|$)', word)
    return [m.group(0) for m in matches]

def split_and_get_type(chunk: str) -> list:
    recipes = [
        (CaseType.KEBAB, lambda w: w.split('-')),
        (CaseType.SNAKE, lambda w: w.split('_')),
        (CaseType.CAMEL, lambda w: split_by_case(w)),
    ]
    caseType = CaseType.OTHER
    words = [chunk]
    lastSize = len(words)
    for (ctype, recipe) in recipes:
        words = list(flatten(map(recipe, words)))
        curSize = len(words)
        if curSize is not lastSize:
            caseType = ctype
        lastSize = curSize

    if caseType is CaseType.CAMEL and words[0][0].isupper():
        caseType = CaseType.PASCAL

    words = map(str.lower, words)
    return list(words), caseType

def join_by_camel(words, isPascal = False):
    chunk = ''
    for i, word in enumerate(words):
        if i is 0 and not isPascal:
            chunk = chunk + word
            continue
        chunk = chunk + word[0].upper() + word[1:]
    return chunk

def join_by_pascal(words):
    return join_by_camel(words, True)

def join_by_case(words: list, caseType: CaseType) -> str:
    joiners = {
        CaseType.SNAKE: (lambda w: '_'.join(w)),
        # CaseType.KABAB: (lambda w: '-'.join(w)),
        CaseType.CAMEL: join_by_camel,
        CaseType.PASCAL: join_by_pascal,
    }
    if caseType not in joiners:
        return ''
    return (joiners[caseType])(words)

def case_master_rotate():
    vim.command("let l:pos = getpos('.')")
    chunk = vim.eval("expand('<cword>')")
    words, caseType = split_and_get_type(chunk)
    if len(words) < 2 or caseType is CaseType.OTHER:
        return
    nextCaseType = caseType.next()
    if (nextCaseType is CaseType.KEBAB) and not is_kebab_active():
        nextCaseType = nextCaseType.next()
    chunk = join_by_case(words, nextCaseType)
    vim.command('normal "_diw')
    vim.command('normal i' + chunk)
    vim.command('call setpos(".", l:pos)')
