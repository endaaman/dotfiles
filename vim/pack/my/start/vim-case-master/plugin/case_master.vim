scriptencoding utf-8

if exists('g:loaded_case_master')
  finish
endif
let g:loaded_case_master = 1

command! CaseMasterRotateCase :call case_master#rotate_case()
command! CaseMasterConvertToSnake :call case_master#convert_to_snake()
command! CaseMasterConvertToKebab :call case_master#convert_to_kebab()
command! CaseMasterConvertToCamel :call case_master#convert_to_camel()
command! CaseMasterConvertToPascal :call case_master#convert_to_pascal()

nnoremap <silent> <C-e> :CaseMasterRotateCase<CR>
