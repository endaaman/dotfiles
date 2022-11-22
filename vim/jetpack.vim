packadd vim-jetpack

function! s:load_config(p) abort
  for path in glob(a:p, 1, 1, 1)
    execute printf('source %s', fnameescape(path))
  endfor
endfunction


call jetpack#begin()

" Common
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
Jetpack 'osyo-manga/vim-precious'
Jetpack 'Yggdroot/indentLine'
Jetpack 'Shougo/echodoc.vim'
Jetpack 'airblade/vim-gitgutter'
Jetpack 'simeji/winresizer'
" Jetpack 'junegunn/vim-easy-align'
"
Jetpack 'lambdalisue/fern.vim'
Jetpack 'lambdalisue/fern-git-status.vim'
Jetpack 'sgur/vim-textobj-parameter'

Jetpack 'goerz/jupytext.vim'
Jetpack 'hanschen/vim-ipython-cell'
Jetpack 'jpalardy/vim-slime'

" Appearance
Jetpack 'chriskempson/base16-vim'
Jetpack 'jacoborus/tender.vim'
Jetpack 'kristijanhusak/vim-hybrid-material'
Jetpack 'cocopon/iceberg.vim'
Jetpack 'arcticicestudio/nord-vim'
Jetpack 'ErichDonGubler/vim-sublime-monokai'
Jetpack 'ayu-theme/ayu-vim'

" Languages
Jetpack 'cespare/vim-toml', {'ft': 'toml'}
Jetpack 'gabrielelana/vim-markdown', {'ft': 'markdown'}
Jetpack 'akhaku/vim-java-unused-imports', {'ft': 'java'}
Jetpack 'digitaltoad/vim-pug', {'ft': ['pug', 'vue']}
Jetpack 'posva/vim-vue', {'ft': 'vue'}
Jetpack 'elzr/vim-json', {'ft': 'json'}
Jetpack 'briancollins/vim-jst', {'ft': ['ejs', 'jst']}
Jetpack 'kchmck/vim-coffee-script', {'ft': 'coffee'}
Jetpack 'jwalton512/vim-blade', {'ft': 'php'}
Jetpack 'leafgarland/typescript-vim', {'ft': 'typescript'}
Jetpack 'keith/tmux.vim', {'ft': 'tmux'}
Jetpack 'tkztmk/vim-vala', {'ft': 'vala'}
Jetpack 'vim-scripts/nginx.vim', {'ft': 'nginx'}
Jetpack 'dag/vim-fish', {'ft': 'fish'}
Jetpack 'def-lkb/ocp-indent-vim', {'ft': 'ocaml'}
Jetpack 'rust-lang/rust.vim', {'ft': 'rust'}
Jetpack 'racer-rust/vim-racer', {'ft': 'rust'}
Jetpack 'rhysd/rust-doc.vim', {'ft': 'rust'}
Jetpack 'mattn/vim-goimports', {'ft': 'go'}

if has('nvim')
  Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }
  Jetpack 'neoclide/coc-denite'
  Jetpack 'Shougo/denite.nvim'
endif

if get(g:, 'rich')
  Jetpack 'endaaman/lightline-hybrid.vim'
  Jetpack 'itchyny/lightline.vim'
  Jetpack 'ryanoasis/vim-devicons'  "call webdevicons#refresh()
endif

call jetpack#end()

for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor

if has('nvim')
  silent! packadd nvim-treesitter
else
  silent! packadd vim-healthcheck
endif

" call s:load_config(expand('<sfile>:p:h') .. '/plugin-pre.d/*.vim')
call s:load_config(expand('<sfile>:p:h') .. '/plugin.d/*.vim')

colorscheme iceberg
