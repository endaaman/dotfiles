scriptencoding utf-8

set nocompatible

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'


if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(expand('~/.vim/dein.toml'), {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

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
set breakindent
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
set noswapfile
set nowrap
set number
set ruler
set shell=sh
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
set wrap
set write

if has('gui_running')
  set guifont=Ubuntu\ Mono\ 11
  set lines=40
  set columns=120
endif

let g:vim_json_syntax_conceal = 0

let g:copypath_copy_to_unnamed_register = 1

autocmd InsertLeave * set cursorline
autocmd InsertEnter * set nocursorline

autocmd BufWritePre * if @% !~ '\.md$' | :%s/\s\+$//e | endif
autocmd BufWritePre * :%s/\t\+$//e
autocmd BufRead,BufNewFile /etc/nginx/* set ft=nginx
autocmd BufEnter * lcd %:p:h

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap <C-j> <C-f>zz
nnoremap <C-k> <C-b>zz
nnoremap J <C-d>zz
nnoremap K <C-u>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
nnoremap H ^
nnoremap L $
nnoremap <C-d> J
nnoremap <C-u> K
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap m :
nnoremap <Return> o
nnoremap <S-Return> O
nnoremap <C-y> :x<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
nnoremap <silent> <C-m> :noh<CR>

nnoremap ZZ <nop>
nnoremap ZQ <nop>

vnoremap v $h
vnoremap H <
vnoremap L >

cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

inoremap <C-l> <Del>
inoremap <S-Space> <C-x>

nnoremap <silent> <C-n> :NERDTreeFind<CR>

" let g:nodejs_complete_config = {
" \  'js_compl_fn': 'jscomplete#CompleteJS',
" \  'max_node_compl_len': 15
" \}


let g:indentLine_color_term = 23

let g:go_highlight_functions = 1
let g:go_highlight_methods = 3
let g:go_highlight_structs = 3

let g:lightline = {
  \ 'colorscheme': 'jellybeans'
  \ }

let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'

" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
" let g:phpcomplete_mappings = {
"   \ 'jump_to_def': ',g',
"   \ }

let NERDTreeShowHidden=1
" nnoremap <silent> <C-n> :NERDTreeTabsToggle<cr>


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
vnoremap /g y:Unite grep::-iRn:<C-r>=escape(@", '\\.*$^[]')<CR><CR>

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
