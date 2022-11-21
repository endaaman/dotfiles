echom 'jet'

packadd vim-jetpack
call jetpack#begin()

Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'Shougo/dein.vim'
Jetpack 'sheerun/vim-polyglot'
Jetpack 'rhysd/conflict-marker.vim'
Jetpack 'editorconfig/editorconfig-vim'
Jetpack 'rking/ag.vim'
Jetpack 'jiangmiao/auto-pairs'
Jetpack 'gregsexton/MatchTag'
Jetpack 'tomtom/tcomment_vim'
Jetpack 'tpope/vim-surround'
Jetpack 'tpope/vim-fugitive'
Jetpack 'kana/vim-textobj-user'
Jetpack 'PeterRincker/vim-argumentative'
Jetpack 'vim-scripts/sudo.vim'


Jetpack 'Shougo/context_filetype.vim'
let g:context_filetype#search_offset = 10000
if !exists('g:context_filetype#filetypes')
  let g:context_filetype#filetypes = {}
endif

let g:context_filetype#filetypes.ipynb =
  \ [{
  \   'filetype' : 'python',
  \   'start' : '^# %%', 'end' : '\(^# %%\|\%$\)'
  \ }, {
  \   'filetype' : 'python',
  \   'start' : '\%^', 'end' : '\(^# %%\|\%$\)'
  \ }, {
  \   'filetype' : '\1',
  \   'start' : '^# %% \[\(\h\w*\)\]', 'end' : '\(^# %%\|\%$\)'
  \ }]


Jetpack 'osyo-manga/vim-precious'
let g:precious_enable_switchers = {
\ '*' : {
\  'setfiletype' : 1
\ },
\ 'vue' : {
\  'setfiletype' : 0
\ },
\}


Jetpack 'Yggdroot/indentLine'
if get(g:, 'rich')
  let g:indentLine_char = ''
else
  let g:indentLine_char = '¦'
endif
let g:indentLine_fileTypeExclude = ['nerdtree', 'markdown']
let g:vim_json_syntax_conceal = 0
let g:indentLine_setConceal = 1
" autocmd EN Filetype json let g:indentLine_setConceal = 0


Jetpack 'Shougo/echodoc.vim'
set noshowmode
" set cmdheight=2
let g:echodoc#enable_at_startup = 1
" let g:echodoc#enable_force_overwrite = 1


Jetpack 'airblade/vim-gitgutter'
nnoremap <C-k> :<C-u>GitGutterPrevHunk<CR>
nnoremap <C-j> :<C-u>GitGutterNextHunk<CR>
autocmd EN BufWritePost * :GitGutter


Jetpack 'simeji/winresizer'
let g:winresizer_start_key = '<Space>R'

" Jetpack 'junegunn/vim-easy-align'

Jetpack 'lambdalisue/fern.vim'
nnoremap <C-g> :<C-u>Fern . -drawer -width=40 -toggle -reveal=% <CR>

autocmd FileType fern setlocal nonumber
autocmd FileType fern setlocal nocursolcolumn

" function! s:on_highlight() abort
"   " Use brighter highlight on root node
"   highlight link FernRootSymbol Title
"   highlight link FernRootText   Title
" endfunction

function! s:init_fern() abort
  nmap <buffer><silent><expr>
    \ <Plug>(fern-my-open-or-expand-collapse)
    \ fern#smart#leaf(
    \   "\<Plug>(fern-action-open)<C-w>:q<CR>",
    \   "\<Plug>(fern-action-expand)",
    \   "\<Plug>(fern-action-collapse)",
    \ )

  nmap <buffer> o <Plug>(fern-my-open-or-expand-collapse)
  nmap <buffer> x <Plug>(fern-action-collapse)
  nmap <buffer> C <Plug>(fern-action-enter)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
  nmap <buffer> q :<C-u>quit<CR>
  " nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
  " nmap <buffer> i <Plug>(fern-action-open:split)
  " nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
  " nmap <buffer> s <Plug>(fern-action-open:vsplit)
  " nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
  " nmap <buffer> ma <Plug>(fern-action-new-path)
  " nmap <buffer> P gg
  " nmap <buffer> u <Plug>(fern-action-leave)
  " nmap <buffer> r <Plug>(fern-action-reload)
  " nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
  " nmap <buffer> cd <Plug>(fern-action-cd)
  " nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>
  " nmap <buffer> I <Plug>(fern-action-hidden-toggle)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

augroup my-fern-highlight
  autocmd!
  autocmd User FernHighlight call s:on_highlight()
augroup END


Jetpack 'lambdalisue/fern-git-status.vim'
" let g:fern_git_status#disable_ignored = 1
" let g:fern_git_status#disable_untracked = 1
let g:fern_git_status#disable_submodules = 1
" let g:fern_git_status#disable_directories = 1

" Jetpack 'lambdalisue/glyph-palette.vim'
" augroup my-glyph-palette
"   autocmd! *
"   autocmd FileType fern call glyph_palette#apply()
"   " autocmd FileType nerdtree,startify call glyph_palette#apply()
" augroup END


" Jetpack 'lambdalisue/fern-renderer-nerdfont.vim'
" let g:fern#renderer = "nerdfont"



Jetpack 'sgur/vim-textobj-parameter'
let g:vim_textobj_parameter_mapping = 'a'


Jetpack 'goerz/jupytext.vim'
let g:jupytext_enable = 1
" セルの区切り文字をVSCode互換の # %% に指定する
let g:jupytext_fmt = 'py:percent'

" vimのPython向けシンタックスハイライトを有効にする
let g:jupytext_filetype_map = {'py:percent': 'ipynb'}


Jetpack 'hanschen/vim-ipython-cell'
" xmap <F5> <Plug>SlimeRegionSend
" nmap <F5> <Plug>SlimeParagraphSend
let g:ipython_cell_regex = 1
let g:ipython_cell_tag = '# %%( [^[].*)?'
nnoremap <Space><C-j> :<C-u>IPythonCellExecuteCell<CR>

Jetpack 'jpalardy/vim-slime'
let g:slime_no_mappings = 1

" ipythonを使う
let g:slime_python_ipython = 1
" セルの区切り文字を指定
let g:slime_cell_delimiter = '# %%'

" TMUX
" let g:slime_target = 'tmux'
" let g:slime_default_config = {
"   \ 'socket_name': get(split($TMUX, ','), 0),
"   \ 'target_pane': '{right-of}' }

" NeoVim terminal
let g:slime_target = 'neovim'
function SlimeOverrideConfig()
  wincmd w
  let l:chan = &channel
  wincmd W
  let b:slime_config = {
    \ 'jobid': l:chan,
    \ }
endfunction
" let g:slime_dont_ask_default = 1

" " 環境変数 $STY から GNU Screen のセッション名を取得する
" let g:slime_default_config = {"sessionname": $STY, "windowname": "ipython3"}

call jetpack#end()
