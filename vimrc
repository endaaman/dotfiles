scriptencoding utf-8
syntax on

set encoding=utf-8
set nowrap

set hlsearch
set ignorecase
set smartcase

set autoindent

set ruler
set list
set wildmenu
set showcmd

set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2
set smarttab

set clipboard=unnamed




syntax enable

if &compatible
  set nocompatible
endif
set runtimepath^=~/.vim/dein.vim

call dein#begin(expand('~/.cache/dein'))

call dein#add('Shougo/neocomplete.vim')
call dein#add('Townk/vim-autoclose')
call dein#add('mattn/emmet-vim')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('altercation/vim-colors-solarized')

call dein#end()


filetype plugin indent on
