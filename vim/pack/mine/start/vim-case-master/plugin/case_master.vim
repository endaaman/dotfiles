scriptencoding utf-8

if exists('g:loaded_case_master')
  finish
endif
let g:loaded_case_master = 1

nnoremap <silent> <C-e> :call case_master#rotate_normal()<CR>
vnoremap <silent> <C-e> :call case_master#rotate_visual()<CR>
