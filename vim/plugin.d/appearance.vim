if get(g:, 'rich')
  let g:indentLine_char = ''
else
  let g:indentLine_char = '¦'
endif
let g:indentLine_fileTypeExclude = ['nerdtree', 'markdown']
let g:vim_json_syntax_conceal = 0
let g:indentLine_setConceal = 1
" autocmd EN Filetype json let g:indentLine_setConceal = 0

" let ayucolor="light"
let ayucolor="mirage"
" let ayucolor="dark"
" autocmd EN VimEnter * nested colorscheme ayu
"
colorscheme iceberg
