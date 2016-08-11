scriptencoding utf-8

if 0 | endif

if &compatible
  set nocompatible
endif

set runtimepath^=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" NeoBundle 'Shougo/neosnippet'
" NeoBundle 'Shougo/neosnippet-snippets'
" NeoBundle 'vim-scripts/Align'
NeoBundle 'ConradIrwin/vim-bracketed-paste'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'fatih/vim-go'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mattn/jscomplete-vim'
NeoBundle 'mhartington/oceanic-next'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'simeji/winresizer'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/nginx.vim'
NeoBundle 'vim-scripts/sudo.vim'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

syntax enable
let g:solarized_termcolors=256
set t_Co=256
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
colorscheme OceanicNext
" colorscheme solarized
set background=dark

set ambiwidth=double
set autoindent
set backupdir=~/.vim/tmp
set clipboard=unnamedplus
set cursorline
set directory=~/.vim/tmp
set encoding=utf-8
set expandtab
set hlsearch
set ignorecase
set laststatus=2
set lazyredraw
set list
set listchars=tab:\|\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set modifiable
set mouse=a
set nobackup
set nocompatible
set nowrap
set number
set ruler
set shiftwidth=2
set showbreak=↪
set showcmd
set smartcase
set smarttab
set softtabstop=2
set tabstop=2
set timeout timeoutlen=1000 ttimeoutlen=50
set ttyfast
set undodir=~/.vim/tmp
set wildmenu
set write

" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
if has('gui_running')
  set guifont=Ubuntu\ Mono\ 11
  set lines=40
  set columns=120
endif

let g:vim_json_syntax_conceal = 0

autocmd InsertEnter,InsertLeave * set cursorline!
" autocmd InsertEnter,InsertLeave * set cursorcolumn!

autocmd BufWritePre * if @% !~ '\.md$' | :%s/\s\+$//e | endif
autocmd BufWritePre * :%s/\t\+$//e
autocmd BufRead,BufNewFile /etc/nginx/* set ft=nginx


inoremap jj <Esc>
vnoremap v $h
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap <Tab> <C-w>w

let g:nodejs_complete_config = {
\  'js_compl_fn': 'jscomplete#CompleteJS',
\  'max_node_compl_len': 15
\}

let g:indentLine_color_term = 23


let g:lightline = {
  \ 'colorscheme': 'jellybeans'
  \ }

let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-d>'


let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'


" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
" let g:phpcomplete_mappings = {
"   \ 'jump_to_def': ',g',
"   \ }

nnoremap <silent> <C-n> :NERDTreeTabsToggle<cr>


" let g:vimfiler_as_default_explorer = 1
" let g:vimfiler_safe_mode_by_default = 0
" let g:vimfiler_edit_action = 'tabopen'

" nnoremap <silent> <Tab> :<C-u>VimFiler -split -simple -no-quit<CR>

autocmd FileType vimfiler nmap <buffer> <Enter>  <Plug>(vimfiler_expand_or_edit)
autocmd FileType vimfiler nmap <buffer> o        <Plug>(vimfiler_cd_or_edit)
autocmd FileType vimfiler nmap <buffer> H        <nop>
autocmd FileType vimfiler nmap <buffer> h        <nop>
autocmd FileType vimfiler nmap <buffer> l        <Plug>(vimfiler_expand_tree)

let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
" let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'


let g:unite_source_grep_command = 'ag'
" let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_max_candidates = 200
let g:unite_source_grep_recursive_opt = ''
" let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
nmap <Space> [unite]
vnoremap /g y:Unite grep::-iRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

call unite#custom#source('buffer', 'converters', ['converter_smart_path'])

nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer file_mru<CR>
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
nnoremap <silent> [unite]g :<C-u>Unite<Space>grep<CR>
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}



