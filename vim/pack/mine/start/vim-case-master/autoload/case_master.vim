scriptencoding utf-8

if !exists('g:loaded_case_master')
    finish
endif
let g:loaded_case_master = 1

pyfile <sfile>:h:h/src/case_master.py

function! case_master#rotate_normal() abort
  python rotate_normal()
endfunction

function! case_master#rotate_visual() abort
  python rotate_visual()
endfunction
