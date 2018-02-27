set all&
augroup E
  autocmd!
augroup END
colorscheme desert

set autoindent
set background=dark
set backspace=indent,eol,start
set backupdir=~/.cache/vim
set cursorline
set directory=~/.cache/vim
set expandtab
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set history=10000
set hlsearch
set ignorecase
set laststatus=2
set lazyredraw
set list
set matchpairs& mps+=<:>
set matchtime=1
set modifiable
set mouse=a
set nobackup
set noswapfile
set number
set ruler
set scrolloff=10
set shell=bash
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set smarttab
set softtabstop=2
set tabstop=2
set timeout timeoutlen=1000 ttimeoutlen=50
set undodir=~/.cache/vim
set undofile
set updatetime=1000
set wildmenu
set wrap
set write

let g:netrw_home=  '~/.cache/vim'
let g:vim_indent_cont = &sw

if $TERM !=# 'linux'
  let g:has_custom_font = 1
endif

if has('nvim')
  let g:python_host_prog = PickExecutable([
    \ '/usr/local/bin/python3',
    \ '/usr/bin/python3',
    \ '/bin/python3',
    \])
  let g:python3_host_prog = PickExecutable([
    \ '/usr/local/bin/python3',
    \ '/usr/bin/python3',
    \ '/bin/python3',
    \])
  set sh=zsh
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  " au TermOpen * if &buftype == 'terminal' | :set nolist | endif
  " au TermClose * set list
endif

if has('win32') || has('win64') || has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamed,unnamedplus
endif

if !has('gui_running') && exists('&termguicolors') && $COLORTERM ==# 'truecolor'
  if !has('nvim')
    let &t_8f = "\e[38;2;%lu;%lu;%lum"
    let &t_8b = "\e[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
endif

if has('gui_running')
  set ambiwidth=double
  set guifont = Monospace\ 10
  au E VimEnter * set lines=40
  au E VimEnter * set columna=120
endif

if exists('g:has_custom_font')
  set listchars=tab:\\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
  set showbreak=↳
endif

au E InsertLeave * set cursorline
au E InsertEnter * set nocursorline
au E BufWritePre * if matchstr(&ft, '\(markdown\|pug\)') == '' | :%s/\s\+$//e | endif
au E BufWritePre * :%s/\t\+$//e
au E BufEnter * :set conceallevel=2
au E VimEnter * :call LoadLocalVimConfig()

