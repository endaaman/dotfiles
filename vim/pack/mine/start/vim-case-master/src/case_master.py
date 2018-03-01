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

def split_by_camel(word: str) -> list:
    matches = re.finditer('.+?(?:(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])|$)', word)
    return [m.group(0) for m in matches]

def split_and_get_type(chunk: str) -> list:
    recipes = [
        (CaseType.KEBAB, lambda w: w.split('-')),
        (CaseType.SNAKE, lambda w: w.split('_')),
        (CaseType.CAMEL, lambda w: split_by_camel(w)),
    ]
    case_type = CaseType.OTHER
    words = [chunk]
    last_size = len(words)
    for (ctype, recipe) in recipes:
        words = list(flatten(map(recipe, words)))
        cur_size = len(words)
        if cur_size is not last_size:
            case_type = ctype
        last_size =cur_size 

    if case_type is CaseType.CAMEL and words[0][0].isupper():
        case_type = CaseType.PASCAL

    words = map(str.lower, words)
    return list(words), case_type 

def join_by_camel(words, is_pascal = False):
    chunk = ''
    for i, word in enumerate(words):
        if i is 0 and not is_pascal:
            chunk = chunk + word
            continue
        chunk = chunk + word[0].upper() + word[1:]
    return chunk

def join_by_pascal(words):
    return join_by_camel(words, True)

def join_by_case(words: list, case_type: CaseType) -> str:
    joiners = {
        CaseType.SNAKE: (lambda w: '_'.join(w)),
        CaseType.KEBAB: (lambda w: '-'.join(w)),
        CaseType.CAMEL: join_by_camel,
        CaseType.PASCAL: join_by_pascal,
    }
    if case_type not in joiners:
        return ''
    return (joiners[case_type])(words)

def rotate_chunk(chunk: str) -> str:
    words, case_type = split_and_get_type(chunk)
    if len(words) < 2 or case_type is CaseType.OTHER:
        return chunk
    next_case_type = case_type.next()
    if (next_case_type is CaseType.KEBAB) and not is_kebab_active():
        next_case_type = next_case_type.next()
    return join_by_case(words, next_case_type)

def rotate_normal():
    vim.command("let l:pos = getcurpos()")
    chunk = rotate_chunk(vim.eval("expand('<cword>')"))
    vim.command('normal "_diw')
    vim.command('normal i' + chunk)
    vim.command('call setpos(".", l:pos)')

def rotate_visual():
    vim.command("let l:pos = getcurpos()")
    cur_l = int(vim.eval('getpos(".")[1]'))
    vim.command('let l:start = getpos("\'<")')
    vim.command('let l:end = getpos("\'>")')
    v_start_l = int(vim.eval('l:start[1]'))
    v_start_c = int(vim.eval('l:start[2]'))
    v_end_l = int(vim.eval('l:end[1]'))
    v_end_c = int(vim.eval('l:end[2]'))

    cur_start_c = 1
    if cur_l is v_start_l:
        cur_start_c = v_start_c
    cur_end_c = int(vim.eval('col("$")')) - 1
    if cur_l is v_end_l:
        cur_end_c = v_end_c

    line = vim.eval('getline(".")')
    selection = line[cur_start_c - 1:cur_end_c]
    print(selection)
