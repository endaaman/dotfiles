scriptencoding utf-8

if exists('g:loaded_case_master')
  finish
endif
let g:loaded_case_master = 1

noremap <silent> <C-e> :call case_master#hello()<CR>
