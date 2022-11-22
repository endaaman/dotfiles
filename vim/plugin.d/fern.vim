nnoremap <C-g> :<C-u>Fern . -drawer -width=40 -toggle -reveal=%<CR>

let g:fern#disable_default_mappings = 1

function! s:init_fern() abort
  setlocal nonumber
  setlocal nocursorcolumn

  nmap <buffer><silent><expr>
    \ <Plug>(fern-my-open-or-expand-collapse)
    \ fern#smart#leaf(
    \   "\<Plug>(fern-action-open)",
    \   "\<Plug>(fern-action-expand)",
    \   "\<Plug>(fern-action-collapse)",
    \ )
  nmap <buffer> o <Plug>(fern-my-open-or-expand-collapse)
  nmap <buffer> <C-m> <Plug>(fern-action-open)<C-w>p:<C-u>quit<CR>
  nmap <buffer> x <Plug>(fern-action-collapse)
  nmap <buffer> C <Plug>(fern-action-enter)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> s <Plug>(fern-action-open:vsplit)
  nmap <buffer> R <Plug>(fern-action-reload)
  nmap <buffer> d <Plug>(fern-action-trash=)
  nmap <buffer> q :<C-u>quit<CR>

  " nmap <buffer> cd <Plug>(fern-action-cd)
  " nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
  " nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
  " nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
  " nmap <buffer> ma <Plug>(fern-action-new-path)
  " nmap <buffer> P gg
  " nmap <buffer> u <Plug>(fern-action-leave)
  " nmap <buffer> r <Plug>(fern-action-reload)
  " nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>
  " nmap <buffer> I <Plug>(fern-action-hidden-toggle)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

function! s:on_highlight() abort
  highlight link FernRootSymbol Title
  highlight link FernRootText   Title
endfunction

augroup my-fern-highlight
  autocmd!
  autocmd User FernHighlight call s:on_highlight()
augroup END



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
