if has('vim_starting')
  scriptencoding utf-8
endif
set encoding=utf-8

augroup EN
  autocmd!
augroup END

" global flags
let g:base_path = expand('<sfile>:p:h')
if $TERM =~# '256color'
  let g:rich = 1
endif

runtime! functions.vim
runtime! basic.vim
runtime! keymaps.vim
runtime! dein.vim
runtime! local.vim

if !exists('*s:source_script')
  function s:source_script() abort
    let ft = &ft
    let colorscheme = g:colors_name
    let path = expand('~/.vim/init.vim')
    if !filereadable(path)
      echomsg printf('"%s" does not exist', simplify(fnamemodify(path, ':~:.')))
      return
    endif
    execute 'source ' fnameescape(path)

    if strlen(expand('%')) > 0
      e!
    endif
    execute 'set ft=' . ft
    execute 'colorscheme ' . colorscheme
    echomsg printf(
      \ '"%s" has sourced (%s)',
      \ simplify(fnamemodify(path, ':~:.')),
      \ strftime('%c'),
      \)
  endfunction
endif
nnoremap <silent> <F10> :<C-u>call <SID>source_script()<CR>

syntax on
filetype indent plugin on

set secure
