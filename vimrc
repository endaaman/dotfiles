" vi: set ft=vim :
set all&
autocmd!
augroup MyAutoGroup
  autocmd!
augroup END
scriptencoding utf-8
if !1 | finish | endif
if !&compatible
  set nocompatible
endif
syntax on

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

if has('gui_running')
  set guifont=Ubuntu\ Mono\ 11
  set lines=40
  set columns=120
  set ambiwidth=double
  highlight Search cterm=NONE ctermfg=grey ctermbg=blue
else
  autocmd ColorScheme * highlight Normal ctermbg=none
  autocmd ColorScheme * highlight LineNr ctermbg=none
endif

set background=dark
filetype plugin indent on
colorscheme OceanicNext

highlight Comment cterm=none
highlight Search guibg=peru guifg=wheat

" set ambiwidth=double
set autoindent
set backupdir=~/.vim/tmp
set backspace=2
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
set t_Co=256
set tabstop=2
set timeout timeoutlen=1000 ttimeoutlen=50
set ttyfast
set undodir=~/.vim/tmp
set undofile
set updatetime=1000
set wildmenu
set wrap
set write

if (v:version == 704 && has("patch338")) || v:version >= 705
  set breakindent
  autocmd MyAutoGroup BufEnter * set breakindentopt=min:20,shift:0
endif

autocmd InsertLeave * set cursorline
autocmd InsertEnter * set nocursorline

autocmd BufRead,BufNewFile *.json.jbuilder set ft=ruby
autocmd BufRead,BufNewFile /etc/nginx/* set ft=nginx

autocmd BufWritePre * if @% !~ '\.md$' | :%s/\s\+$//e | endif
autocmd BufWritePre * :%s/\t\+$//e

autocmd FileType nerdtree setlocal nolist
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd BufEnter * execute ":lcd " . expand("%:p:h")

function! IndentWithI()
  if len(getline('.')) == 0
     return 'cc'
  else
    return 'i'
  endif
endfunction

function! SwapWithAboveLine()
  if line('.') == 1
    return ''
  else
    return '"zddk"zP'
  endif
endfunction

noremap j gj
noremap k gk
noremap J <C-d>zz
noremap K <C-u>zz
" noremap J gjzz
" noremap K gkzz
" nnoremap <C-f> <C-d>zz
" nnoremap <C-b> <C-u>zz
noremap H ^
noremap L $
noremap m :
noremap x "_x

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap o o<Esc>
nnoremap O O<Esc>
nnoremap Y y$
nnoremap G Gzz
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap <C-a> ggVG
nnoremap <C-j> "zdd"zp
nnoremap <expr> <C-k> SwapWithAboveLine()
nnoremap <C-d> :<C-u>q<CR>
nnoremap <C-x> :<C-u>x<CR>
nnoremap <C-s> :<C-u>w<CR>
nnoremap <C-u> :<C-u>noh<CR>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap - <C-x>
nnoremap + <C-a>
nnoremap <Down> <C-x>
nnoremap <Up> <C-a>
nnoremap * viw"zy:<C-u>let @/ = @z\|set hlsearch<CR>

nnoremap <expr> i IndentWithI()

nnoremap <C-n> :<C-u>tabn<CR>
nnoremap <C-p> :<C-u>tabp<CR>
nnoremap <C-@> <C-l>

vnoremap v $h
vnoremap <Space> o
vnoremap * "zy:<C-u>let @/ = @z\|set hlsearch<CR>gv
vnoremap > >gv
vnoremap < <gv
" vnoremap p :<C-u>"0p<CR>

inoremap <BS> <Nop>
inoremap <C-l> <Del>
inoremap <C-s> <C-o>:<C-u>w<CR>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

nnoremap <C-m> <Nop>
nnoremap <C-c> <Nop>
nnoremap <C-h> <nop>
nnoremap <C-l> <nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <C-t> <Nop> " tmux prefix
nnoremap <C-y> <Nop> " Resizer
nnoremap <C-e> <Nop> " emmet

nnoremap <C-g> :<C-u>NERDTree<CR> <C-l>
" nnoremap <silent> <C-y> :<C-u>VimFiler -split -no-quit<CR>

" let g:nodejs_complete_config = {
" \  'js_compl_fn': 'jscomplete#CompleteJS',
" \  'max_node_compl_len': 15
" \}

" command! -range -nargs=0 -bar JsonTool <line1>,<line2>!python -m json.tool

let g:user_emmet_leader_key='<C-e>'

let g:vim_json_syntax_conceal = 0

let g:copypath_copy_to_unnamed_register = 1

let g:winresizer_start_key = '<C-e>'

let g:indentLine_color_term = 23

let g:go_highlight_functions = 1
let g:go_highlight_methods = 3
let g:go_highlight_structs = 3

let g:lightline = {
\ 'colorscheme': 'jellybeans'
\ }

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'
let g:neocomplete#sources#omni#input_patterns.py = '\h\w\.\w*'

autocmd FileType php setlocal omnifunc=jedi#completions

" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
" let g:phpcomplete_mappings = {
"   \ 'jump_to_def': ',g',
"   \ }

let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let NERDTreeShowHidden=1
let NERDTreeHijackNetrw=1



" let g:vimfiler_as_default_explorer = 1
" let g:vimfiler_edit_action = 'tabopen'
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_ignore_pattern = ''


autocmd FileType vimfiler nmap <buffer> <Enter>  <Plug>(vimfiler_expand_or_edit)
autocmd FileType vimfiler nmap <buffer> o        <Plug>(vimfiler_cd_or_edit)
autocmd FileType vimfiler nmap <buffer> H        <nop>
autocmd FileType vimfiler nmap <buffer> h        <nop>
autocmd FileType vimfiler nmap <buffer> l        <Plug>(vimfiler_expand_tree)

let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = ''
let g:vimfiler_marked_file_icon = '*'

" let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_max_candidates = 200
let g:unite_source_grep_recursive_opt = ''
" let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

call unite#custom#source('buffer', 'converters', ['converter_smart_path'])
call unite#custom_source('file', 'ignore_pattern', '')
call unite#custom#source('file', 'matchers', 'matcher_default')

nmap <Space> [unite]
vnoremap /g y:Unite grep::-iRn:<C-r>=escape(@", '\\.*$^[]')<CR><CR>

nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
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


let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "M"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
