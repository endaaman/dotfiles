if (v:version == 704 && has("patch338")) || v:version >= 705
  set breakindent
  autocmd MyAutoCmd BufEnter * set breakindentopt=min:20,shift:0
endif

autocmd InsertLeave * set cursorline
autocmd InsertEnter * set nocursorline

autocmd BufRead,BufNewFile *.json.jbuilder set ft=ruby
autocmd BufRead,BufNewFile /etc/nginx/* set ft=nginx

autocmd BufWritePre * if @% !~ '\.md$' | :%s/\s\+$//e | endif
autocmd BufWritePre * :%s/\t\+$//e

autocmd FileType nerdtree setlocal nolist
autocmd StdinReadPre * let s:std_in=1


if has('gui_running')
  set guifont=Ubuntu\ Mono\ 11
  set lines=40
  set columns=120
  set ambiwidth=double
else
endif


" set ambiwidth=double
set autoindent
set backupdir=~/.cache/vim
set backspace=2
set clipboard=unnamedplus
set cursorline
set directory=~/.cache/vim
set encoding=utf-8
set expandtab
set hlsearch
set ignorecase
set laststatus=2
set lazyredraw
set list
set listchars=tab:\|\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set matchpairs& mps+=<:>
set matchtime=1
set modifiable
set mouse=a
set nobackup
set noswapfile
set nowrap
set number
set ruler
set shell=sh
set shiftwidth=2
set showbreak=↳
set showcmd
set showmatch
set smartcase
set smarttab
set softtabstop=2
set tabstop=2
set timeout timeoutlen=1000 ttimeoutlen=50
set ttyfast
set undodir=~/.cache/vim
set undofile
set updatetime=1000
set wildmenu
set wrap
set write



