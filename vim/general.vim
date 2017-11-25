autocmd InsertLeave * set cursorline
autocmd InsertEnter * set nocursorline

autocmd BufWritePre * if @% !~ '\.md$' | :%s/\s\+$//e | endif
autocmd BufWritePre * :%s/\t\+$//e
autocmd VimEnter * :call LoadLocalVimConfig()

if (v:version == 704 && has("patch338")) || v:version >= 705
  set breakindent
  autocmd Endaaman BufEnter * set breakindentopt=min:20,shift:0
endif

if has('gui_running') || exists('g:nyaovim_version')
  set guifont = Monospace\ 10
  autocmd VimEnter * set lines=40
  autocmd VimEnter * set columna=120
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
endif

set background=dark " always be dark
if has('termguicolors')
  set termguicolors
endif

let g:vim_indent_cont = &sw * 0

set autoindent
" set ambiwidth=double
set backspace=2
set backupdir=~/.cache/vim
set clipboard=unnamedplus
set cursorline
set directory=~/.cache/vim
set encoding=utf-8
set expandtab
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set hlsearch
set ignorecase
set laststatus=2
set lazyredraw
set list
set listchars=tab:\\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set matchpairs& mps+=<:>
set matchtime=1
set modifiable
set mouse=a
set nobackup
set noswapfile
set wrap
set number
set ruler
set scrolloff=10
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
set write
