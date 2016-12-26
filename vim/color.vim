syntax enable
set t_Co=256
set background=dark
" if (has("termguicolors"))
"  set termguicolors
" endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if has('gui_running')
  highlight Search cterm=NONE ctermfg=grey ctermbg=blue
else
  autocmd ColorScheme * highlight Normal ctermbg=none
  autocmd ColorScheme * highlight LineNr ctermbg=none
endif

silent! colorscheme OceanicNext

highlight Comment cterm=none
highlight Search guibg=peru guifg=wheat
highlight CursorLineNr term=bold cterm=NONE ctermfg=228
