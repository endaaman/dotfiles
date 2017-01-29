augroup MyAutoCmd
  autocmd!
augroup END
set all&

set shell=/bin/bash
set history=10000

set notimeout ttimeout ttimeoutlen=100

if has('multi_byte')
  if has('vim_starting')
    set encoding=utf-8
  endif
  scriptencoding utf-8
  set fileencodings=ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,utf-16,utf-16le
  set fileformats=unix,dos,mac
endif

syntax on

runtime! base.vim
runtime! keymap.vim
runtime! dein.vim
runtime! color.vim
