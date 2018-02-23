scriptencoding utf-8

echo 1

if exists('g:loaded_case_master')
    finish
endif
let g:loaded_case_master = 1

nnoremap <C-e> :call case_master#helloworld()<CR>
