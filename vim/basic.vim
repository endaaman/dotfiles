scriptencoding utf-8
let s:columns = &columns
let s:lines = &lines
set all&
execute 'set columns=' . s:columns
execute 'set lines=' . s:lines

syntax enable
filetype plugin on
filetype indent on

set autoindent
set background=dark
set backspace=indent,eol,start
set backupdir=~/.cache/vim
set completeopt-=preview
set conceallevel=0
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
set nofoldenable
set noswapfile
set number
set ruler
set scrolloff=15
set shell=$SHELL
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
set nopaste

let g:netrw_home = '~/.cache/vim'
let g:vim_indent_cont = &shiftwidth
let g:tex_conceal = ""

if has('win32') || has('win64') || has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif


" Set clipboard based on environment and available executables
if $XDG_SESSION_TYPE ==# 'wayland' && executable('wl-copy') && executable('wl-paste')
  let g:clipboard = {
    \ 'name': 'wl-clipboard',
    \ 'copy': {
    \   '+': ['wl-copy'],
    \   '*': ['wl-copy', '--primary'],
    \ },
    \ 'paste': {
    \   '+': ['wl-paste', '--no-newline'],
    \   '*': ['wl-paste', '--no-newline', '--primary'],
    \ },
    \ 'cache_enabled': 1,
    \ }
elseif executable('xsel')
  let g:clipboard = {
    \ 'name': 'xsel',
    \ 'copy': {
    \   '+': ['xsel', '--nodetach', '-i', '-b'],
    \   '*': ['xsel', '--nodetach', '-i', '-p'],
    \ },
    \ 'paste': {
    \   '+': ['xsel', '-o', '-b'],
    \   '*': ['xsel', '-o', '-p'],
    \ },
    \ 'cache_enabled': 1,
    \ }
endif

if !has('gui_running') && exists('&termguicolors') && $COLORTERM ==# 'truecolor'
  "let &t_8f = "\e[38;2;%lu;%lu;%lum"
  "let &t_8b = "\e[48;2;%lu;%lu;%lum"
  set showbreak=↳
  set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
  set termguicolors
else
  set t_Co=256
  set listchars=tab:\\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
endif

if has('gui_running')
  set ambiwidth=double
  set guifont=Monospace\ 10
  autocmd EN VimEnter * set lines=40
  autocmd EN VimEnter * set columns=120
endif

autocmd EN ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
" autocmd EN ColorScheme * highlight NormalNC guibg=NONE ctermbg=NONE
" autocmd EN ColorScheme * highlight Text guibg=NONE ctermbg=NONE
autocmd EN ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
autocmd EN ColorScheme * highlight LineNr guibg=NONE ctermbg=NONE
autocmd EN ColorScheme * highlight EndOfBuffer guibg=NONE ctermbg=NONE

autocmd EN InsertLeave * set cursorline | set cursorcolumn
autocmd EN InsertEnter * set nocursorline | set nocursorcolumn | set paste
" autocmd EN CursorHold * call ShiftRegister()
autocmd EN InsertLeave * set nopaste

autocmd EN BufRead,BufNewFile *.json.jbuilder setlocal ft=ruby
autocmd EN BufRead,BufNewFile Schemafile setlocal ft=ruby
autocmd EN BufRead,BufNewFile /etc/nginx/* setlocal ft=nginx
autocmd EN BufRead,BufNewFile *.ejs setlocal ft=ejs
autocmd EN BufRead,BufNewFile *.vue setlocal ft=vue
autocmd EN BufRead,BufNewFile *.kdl setlocal ft=kdl
autocmd EN BufRead,BufNewFile fonts.conf setlocal ft=xml

let g:netrw_banner = 0        " バナーを非表示
let g:netrw_liststyle = 3     " ツリー表示
