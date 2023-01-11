set encoding=utf-8
scriptencoding utf-8
if has('vim_starting')
  filetype off
endif

augroup EN
  autocmd!
augroup END

if $TERM =~# '256color' && !exists('g:rich') && !$SSH_CONNECTION
  let g:rich = 1
endif

let g:dein_dir = expand('~/.cache/dein')
" let g:jetpack_file = stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let g:vimplug_file = stdpath('data') .. '/site/autoload/plug.vim'

if $USER != 'root' && !$VIM_NO_PLUGS
  if $VIM_USE_DEIN && isdirectory(g:dein_dir)
    let g:dein = 1
  elseif filereadable(g:vimplug_file)
    let g:vimplug = 1
  endif
endif

runtime! functions.vim
runtime! basic.vim
runtime! keymaps.vim
if get(g:, 'dein')
  runtime! dein.vim
elseif get(g:, 'vimplug')
  runtime! vimplug.vim
else
  runtime! vanilla.vim
endif
runtime! local.vim

if !exists('*Reload')
  function! Reload() abort
    let l:ft = &filetype
    let l:colorscheme = g:colors_name
    let l:path = expand('~/.vim/init.vim')
    if !filereadable(l:path)
      echomsg printf('"%s" does not exist', simplify(fnamemodify(l:path, ':~:.')))
      return
    endif
    execute 'source ' fnameescape(l:path)

    if strlen(expand('%')) > 0
      e!
    endif
    execute 'setlocal ft=' . ft
    execute 'colorscheme ' . l:colorscheme
    echom printf(
      \ '"%s" has sourced (%s)',
      \ simplify(fnamemodify(l:path, ':~:.')),
      \ strftime('%c'),
      \)
    if !exists('*ReloadHook')
      call ReloadHook()
    endif
  endfunction
  command! Reload :call Reload()
endif
nnoremap <F10> :<C-u>Reload<CR>

if has('vim_starting')
  filetype plugin indent on
  syntax enable
endif
set secure

doautocmd User MyVimrcLoaded
