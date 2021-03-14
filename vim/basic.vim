scriptencoding utf-8
let s:columns = &columns
let s:lines = &lines
set all&
execute 'set columns=' . s:columns
execute 'set lines=' . s:lines

set autoindent
set background=dark
set backspace=indent,eol,start
set backupdir=~/.cache/vim
set completeopt-=preview
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

let g:netrw_home = '~/.cache/vim'
let g:vim_indent_cont = &shiftwidth
let g:tex_conceal = ""

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
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  " au TermOpen * if &buftype == 'terminal' | :set nolist | endif
  " au TermClose * set list
else
  " set pyxversion=3
endif

if has('win32') || has('win64') || has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
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

if get(g:, 'rich')
  set showbreak=↳
  if has('gui_running')
    set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
  else
    set listchars=tab:\\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
  endif
endif

autocmd EN ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
" autocmd EN ColorScheme * highlight NormalNC guibg=NONE ctermbg=NONE
" autocmd EN ColorScheme * highlight Text guibg=NONE ctermbg=NONE
autocmd EN ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
autocmd EN ColorScheme * highlight LineNr guibg=NONE ctermbg=NONE
autocmd EN ColorScheme * highlight EndOfBuffer guibg=NONE ctermbg=NONE

autocmd EN InsertLeave * set cursorline | set cursorcolumn
autocmd EN InsertEnter * set nocursorline | set nocursorcolumn
autocmd EN CursorHold * call ShiftRegister()
autocmd EN InsertLeave * set nopaste

highlight default TrailingSpaces ctermbg=green guibg=green
autocmd EN ColorScheme * highlight default TrailingSpaces ctermbg=green guibg=green
let s:match_trailing_spaces_ignores = ['defx', 'qf', 'nerdtree']
autocmd EN BufEnter,InsertEnter,InsertLeave,FileType * call MatchTrailingSpaces(0, s:match_trailing_spaces_ignores)
" autocmd EN BufWinLeave * call clearmatches()
" autocmd EN BufWritePre * call TrimTrailingSpaces()
" autocmd EN BufWritePre * call TrimTrailingTabs()

autocmd EN User MyVimrcLoaded call LoadLocalVimConfig()
autocmd EN BufReadPost,FileType * call LoadFtConfig()
autocmd EN BufRead,BufNewFile *.json.jbuilder setlocal ft=ruby
autocmd EN BufRead,BufNewFile Schemafile setlocal ft=ruby
autocmd EN BufRead,BufNewFile /etc/nginx/* setlocal ft=nginx
autocmd EN BufRead,BufNewFile *.ejs setlocal ft=ejs
autocmd EN BufRead,BufNewFile *.vue setlocal ft=vue
autocmd EN BufRead,BufNewFile fonts.conf setlocal ft=xml
