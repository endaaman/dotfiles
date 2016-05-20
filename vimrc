scriptencoding utf-8
set encoding=utf-8
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

syntax enable

if &compatible
  set nocompatible
endif
set runtimepath^=~/.vim/dein

call dein#begin(expand('~/.cache/dein'))

call dein#add('Shougo/neocomplete.vim')
call dein#add('Townk/vim-autoclose')
call dein#add('mattn/emmet-vim')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('altercation/vim-colors-solarized')

call dein#end()


filetype plugin indent on
