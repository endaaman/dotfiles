packadd vim-jetpack

function! s:load_config(p) abort
  for path in glob(a:p, 1, 1, 1)
    execute printf('source %s', fnameescape(path))
  endfor
endfunction

function! s:load_lua(p) abort
  for path in glob(a:p, 1, 1, 1)
    execute printf('luafile %s', fnameescape(path))
  endfor
endfunction

" call jetpack#begin()
call plug#begin()

" Common
" Plug 'tani/vim-jetpack', {'opt': 1} "bootstrap
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'rhysd/conflict-marker.vim'
" Plug 'rking/ag.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'gregsexton/MatchTag'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'kana/vim-textobj-user'
Plug 'PeterRincker/vim-argumentative'
Plug 'vim-scripts/sudo.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'osyo-manga/vim-precious'
Plug 'Yggdroot/indentLine'
Plug 'Shougo/echodoc.vim'
Plug 'airblade/vim-gitgutter'
Plug 'simeji/winresizer'
" Plug 'thinca/vim-quickrun'
" Plug 'kana/vim-textobj-user'
" Plug 'thinca/vim-textobj-between'
" Plug 'thinca/vim-textobj-keyvalue'
" Plug 'sgur/vim-textobj-parameter'
" Plug 'junegunn/vim-easy-align'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'

Plug 'goerz/jupytext.vim'
Plug 'hanschen/vim-ipython-cell'
Plug 'jpalardy/vim-slime'

" Appearance
Plug 'cocopon/iceberg.vim'
Plug 'EdenEast/nightfox.nvim'
" Plug 'chriskempson/base16-vim'
Plug 'jacoborus/tender.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'arcticicestudio/nord-vim'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'ayu-theme/ayu-vim'

" Languages
Plug 'cespare/vim-toml', {'ft': 'toml'}
Plug 'gabrielelana/vim-markdown', {'ft': 'markdown'}
Plug 'akhaku/vim-java-unused-imports', {'ft': 'java'}
Plug 'digitaltoad/vim-pug', {'ft': ['pug', 'vue']}
Plug 'posva/vim-vue', {'ft': 'vue'}
Plug 'elzr/vim-json', {'ft': 'json'}
Plug 'briancollins/vim-jst', {'ft': ['ejs', 'jst']}
Plug 'kchmck/vim-coffee-script', {'ft': 'coffee'}
Plug 'jwalton512/vim-blade', {'ft': 'php'}
Plug 'leafgarland/typescript-vim', {'ft': 'typescript'}
Plug 'keith/tmux.vim', {'ft': 'tmux'}
Plug 'tkztmk/vim-vala', {'ft': 'vala'}
Plug 'vim-scripts/nginx.vim', {'ft': 'nginx'}
Plug 'dag/vim-fish', {'ft': 'fish'}
Plug 'def-lkb/ocp-indent-vim', {'ft': 'ocaml'}
Plug 'rust-lang/rust.vim', {'ft': 'rust'}
Plug 'racer-rust/vim-racer', {'ft': 'rust'}
Plug 'rhysd/rust-doc.vim', {'ft': 'rust'}
Plug 'mattn/vim-goimports', {'ft': 'go'}
Plug 'imsnif/kdl.vim', {'ft': 'kdl'}

if has('nvim')
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
  Plug 'fannheyward/telescope-coc.nvim'
  " Plug 'neoclide/coc-denite'
  " Plug 'Shougo/denite.nvim'
endif

if get(g:, 'rich')
  Plug 'endaaman/lightline-hybrid.vim'
  Plug 'itchyny/lightline.vim'

  " Plug 'ryanoasis/vim-devicons'  "call webdevicons#refresh()
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  " Plug 'lambdalisue/fern-renderer-devicons.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  if has('nvim')
    Plug 'nvim-tree/nvim-web-devicons'
  endif
endif

call plug#end()
" call jetpack#end()

" for name in jetpack#names()
"   if !jetpack#tap(name)
"     call jetpack#sync()
"     break
"   endif
" endfor

if has('nvim')
  silent! packadd nvim-treesitter
else
  silent! packadd vim-healthcheck
endif

" call s:load_config(expand('<sfile>:p:h') .. '/plugin-pre.d/*.vim')
call s:load_config(expand('<sfile>:p:h') .. '/plugin.d/*.vim')
if has('nvim')
  call s:load_lua(expand('<sfile>:p:h') .. '/plugin.d/*.lua')
endif

colorscheme iceberg
