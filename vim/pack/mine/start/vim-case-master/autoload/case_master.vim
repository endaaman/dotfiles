scriptencoding utf-8

if !exists('g:loaded_case_master')
    finish
endif
let g:loaded_case_master = 1

let s:python_result = ''
pyfile <sfile>:h:h/src/case_master.py


" snake_case
" kebab-case
" camelCase
" PascalCase

" conbimed pattern
" kebab-cam?lCase -> kebab-[camel, case]
" k?bab-cam?lCase -> kebab-[camel, case]
" snake_camelCase -> none or convert all
" snake_kebab-case -> convert all

function! case_master#rotate() abort
  python case_master_rotate()
endfunction
