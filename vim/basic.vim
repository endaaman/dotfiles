set all&


colorscheme evening

set autoindent
set background=dark
set backspace=indent,eol,start
set backupdir=~/.cache/vim
set cursorcolumn
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
set scrolloff=15
set shell=bash
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set smarttab
set softtabstop=2
set switchbuf=usetab
set tabstop=2
set timeout timeoutlen=1000 ttimeoutlen=50
set undodir=~/.cache/vim
set undofile
set updatetime=1000
set wildmenu
set wrap
set write

let g:netrw_home = '~/.cache/vim'
let g:vim_indent_cont = &sw

if has('nvim')
  let g:python_host_prog = PickExecutable([
    \ '/usr/local/bin/python',
    \ '/usr/bin/python',
    \ '/bin/python',
    \])
  let g:python3_host_prog = PickExecutable([
    \ '/usr/local/bin/python3',
    \ '/usr/bin/python3',
    \ '/bin/python3',
    \])
  set sh=zsh
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  " au TermOpen * if &buftype == 'terminal' | :set nolist | endif
  " au TermClose * set list
else
  set pyxversion=3
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
  set guifont=Monospace\ 10
  autocmd EN VimEnter * set lines=40
  autocmd EN VimEnter * set columns=120
endif

if exists('g:rich')
  set showbreak=↳
  if has('gui_running')
    set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
  else
    set listchars=tab:\\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
  endif
endif

autocmd EN InsertLeave * set cursorline | set cursorcolumn
autocmd EN InsertEnter * set nocursorline | set nocursorcolumn
" autocmd EN BufWritePre * call TrimTrailingSpaces()
autocmd EN BufWritePre * %s/\t\+$//e
" autocmd EN BufEnter * set conceallevel=0 " problem in NERDTree
autocmd EN VimEnter * call LoadLocalVimConfig()
autocmd EN BufRead,BufNewFile,FileType, * call LoadFtConig()
autocmd EN BufRead,BufNewFile *.vue set ft=vue
autocmd EN BufRead,BufNewFile *.json.jbuilder set ft=ruby
autocmd EN BufRead,BufNewFile Schemafile set ft=ruby
autocmd EN BufRead,BufNewFile /etc/nginx/* set ft=nginx
autocmd EN BufRead,BufNewFile *.ejs set ft=ejs


let s:match_trailing_spaces_ignores = ['defx', 'qf', 'nerdtree']
highlight default ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$/
autocmd EN BufWinEnter,InsertLeave,FileType * call MatchTrailingSpaces(0, s:match_trailing_spaces_ignores)
autocmd EN InsertEnter * call MatchTrailingSpaces(1, s:match_trailing_spaces_ignores)
autocmd EN BufWinLeave * call clearmatches()
autocmd EN CursorHold * call VagueHook()
autocmd EN InsertLeave * set nopaste
