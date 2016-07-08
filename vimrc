scriptencoding utf-8
syntax on

set encoding=utf-8
set nowrap

set hlsearch
set ignorecase
set smartcase
set nocompatible

set autoindent
set ruler
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set wildmenu
set showcmd
set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2
set smarttab
set autochdir
set nobackup
" set backupdir=~/.vim/backup
set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!

set clipboard=unnamed,autoselect
set mouse=a

nmap <silent> <Esc><Esc> :nohlsearch<CR>

nnoremap <S-Up> v<Up>
nnoremap <S-Down> v<Down>
nnoremap <S-Left> v<Left>
nnoremap <S-Right> v<Right>

vnoremap <S-Up> k
vnoremap <S-Down> j
vnoremap <S-Left> h
vnoremap <S-Right> l

noremap! <C-Up> ddkkp
noremap! <C-Down> ddjjp

noremap <C-k> <Plug>(caw:i:toggle)
nnoremap <C-d> <Nop>

nnoremap <silent><C-e> :NERDTreeTabsToggle<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT


let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-d>'


let g:airline_powerline_fonts = 1
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11

command Pbcopy0 :let @*=@0

let NERDTreeShowHidden = 1
 


if 0 | endif

if &compatible
 set nocompatible
endif

set runtimepath^=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'ConradIrwin/vim-bracketed-paste'
NeoBundle 'fatih/vim-go'
NeoBundle 'tyru/caw.vim.git'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'mhartington/oceanic-next'
NeoBundle 'ryanoasis/vim-devicons'

call neobundle#end()

filetype plugin indent on

set t_Co=256
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
colorscheme OceanicNext
 set background=dark

" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
NeoBundleCheck
