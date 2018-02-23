scriptencoding utf-8

if !exists('g:loaded_case_master')
    finish
endif
let g:loaded_case_master = 1

function! case_master#helloworld() abort
  echom "Hello World!"
endfunction
