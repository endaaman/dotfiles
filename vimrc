scriptencoding utf-8

if 0 | endif

if &compatible
  set nocompatible
endif

set runtimepath^=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'ConradIrwin/vim-bracketed-paste'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mattn/jscomplete-vim'
NeoBundle 'mhartington/oceanic-next'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'simeji/winresizer'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'shawncplus/phpcomplete.vim'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

syntax on

set t_Co=256
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
colorscheme OceanicNext
set background=dark


set autoindent
set backupdir=~/.vim/tmp
set clipboard=unnamedplus
set cursorline
set directory=~/.vim/tmp
set encoding=utf-8
set expandtab
set expandtab
set hlsearch
set ignorecase
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set modifiable
set nobackup
set nocompatible
set nowrap
set number
set ruler
set shiftwidth=2
set showcmd
set smartcase
set smarttab
set softtabstop=2
set tabstop=2
set timeout timeoutlen=1000 ttimeoutlen=50
set undodir=~/.vim/tmp
set wildmenu
set write
set mouse=a

autocmd InsertEnter,InsertLeave * set cursorline!

autocmd BufWritePre * if @% !~ '\.md$' | :%s/\s\+$//e | endif
autocmd BufWritePre * :%s/\t\+$//e


let g:nodejs_complete_config = {
\  'js_compl_fn': 'jscomplete#CompleteJS',
\  'max_node_compl_len': 15
\}


let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level= 1
let g:indent_guides_guide_size = 1
" let g:indent_guides_color_change_percent = 30
let g:indent_guides_auto_colors=0
" hi IndentGuidesOdd ctermbg=24
hi IndentGuidesEven ctermbg=23
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'vimfiler']


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


autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
let g:phpcomplete_mappings = {
  \ 'jump_to_def': ',g',
  \ }


set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11

" nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>

" let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
" let g:vimfiler_edit_action = 'tabopen'

nnoremap <silent> <Tab> :<C-u>VimFiler -split -simple -no-quit<CR>

autocmd FileType vimfiler nmap <buffer> <Enter>  <Plug>(vimfiler_expand_or_edit)
autocmd FileType vimfiler nmap <buffer> o        <Plug>(vimfiler_cd_or_edit)
autocmd FileType vimfiler nmap <buffer> H        <nop>
autocmd FileType vimfiler nmap <buffer> h        <nop>
autocmd FileType vimfiler nmap <buffer> l        <Plug>(vimfiler_expand_tree)


let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
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
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
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



