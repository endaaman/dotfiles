autocmd InsertLeave * set cursorline
autocmd InsertEnter * set nocursorline

autocmd BufWritePre * if @% !~ '\.md$' | :%s/\s\+$//e | endif
autocmd BufWritePre * :%s/\t\+$//e

function! LoadLocalVimConfig()
  let s:local_vim = getcwd() . '/.vim/init.vim'
  if filereadable(s:local_vim) && getcwd() != expand('~')
    execute 'source ' . s:local_vim
  endif
endfunction
autocmd VimEnter * :call LoadLocalVimConfig()

if (v:version == 704 && has("patch338")) || v:version >= 705
  set breakindent
  autocmd MyAutoCmd BufEnter * set breakindentopt=min:20,shift:0
endif

if has('gui_running') || exists('g:nyaovim_version')
  set guifont=Monospace\ 11
  autocmd VimEnter * set lines=40
  autocmd VimEnter * set columns=120
  set ambiwidth=double
else
  set t_Co=256
endif

if has('nvim')
  let g:python3_host_prog = '/usr/bin/python3'
  set sh=zsh
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  " autocmd TermOpen * if &buftype == 'terminal' | :set nolist | endif
  " autocmd TermClose * set list
else
endif

if has('termguicolors')
  set termguicolors
endif

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
set listchars=tab:\¦\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
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
set wildmode=list:longest
set wrap
set write
