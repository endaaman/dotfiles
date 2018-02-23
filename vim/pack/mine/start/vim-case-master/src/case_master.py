# coding=utf-8
import vim
import re
from operator import add
from functools import reduce


def flatten(l: list) -> list:
    return reduce(add, l)

def get_keyword_splitters() -> tuple:
    splitters = vim.eval('&iskeyword').split(',')
    return ('-' in splitters, '_' in splitters)

def split_by_case(word: str) -> list:
    matches = re.finditer('.+?(?:(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])|$)', word)
    return [m.group(0) for m in matches]

def split_smartly(chunk: str) -> list:
    words = [chunk]
    words = flatten([ word.split('-') for word in words])
    words = flatten([ word.split('_') for word in words])
    words = flatten([ split_by_case(word) for word in words])
    words = [ word.lower() for word in words]
    return list(words)

def case_master_hello():
    vim.command("let l:pos = getpos('.')")
    chunk = vim.eval("expand('<cword>')")
    words = split_smartly(chunk)
    if len(words) < 2:
        return
    vim.command('normal "_diw')
    vim.command('normal i' + '_'.join(words))
    vim.command('call setpos(".", l:pos)')
