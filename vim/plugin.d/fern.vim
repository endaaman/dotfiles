nnoremap <C-g> :<C-u>Fern . -drawer -width=40 -toggle -reveal=%<CR>
nnoremap <Space><C-g> :<C-u>Fern %:h -drawer -width=40 -toggle -reveal=%<CR>

let g:fern#default_hidden = 1
let g:fern#hide_cursor = 1

let hide_dirs  = '^\%(\.git\|node_modules\|__pycache__\)$'
let hide_files = '\%(\.byebug\|\.ruby-\)\+'
let g:fern#default_exclude = hide_dirs . '\|' . hide_files  " here you exclude them

let g:fern#disable_default_mappings = 1
if get(g:, 'rich')
  let g:fern#renderer = 'nerdfont'
  " let g:fern#renderer = 'devicons'
endif

function! s:init_fern() abort
  setlocal nonumber
  setlocal nocursorcolumn
  " setlocal guicursor=n:hor2000
  "
  nnoremap <Plug>(fern-close-drawer) :<C-u>FernDo close -drawer -stay<CR>

  nmap <buffer><silent> <Plug>(fern-my-open-and-close)
      \ <Plug>(fern-action-open)
      \ <Plug>(fern-close-drawer)

  nmap <buffer><silent><expr>
    \ <Plug>(fern-my-open-close-expand-collapse)
    \ fern#smart#leaf(
    \   "\<Plug>(fern-my-open-and-close)",
    \   "\<Plug>(fern-action-expand)",
    \   "\<Plug>(fern-action-collapse)",
    \ )

  nmap <buffer><silent><expr>
    \ <Plug>(fern-my-open-expand-collapse)
    \ fern#smart#leaf(
    \   "\<Plug>(fern-action-open)",
    \   "\<Plug>(fern-action-expand)",
    \   "\<Plug>(fern-action-collapse)",
    \ )

  nmap <buffer> o <Plug>(fern-my-open-close-expand-collapse)
  nmap <buffer> O <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <C-m> <Plug>(fern-action-open)<Plug>(fern-close-drawer)
  nmap <buffer> x <Plug>(fern-action-collapse)
  nmap <buffer> C <Plug>(fern-action-enter)
  " nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)gT:<C-u>FernDo close -drawer -stay<CR>gt
  nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> s <Plug>(fern-action-open:vsplit)
  nmap <buffer> X <Plug>(fern-action-open:system)
  nmap <buffer> R <Plug>(fern-action-reload)

  nmap <buffer> A <Plug>(fern-action-new-path=)
  nmap <buffer> m <Plug>(fern-action-mark)j
  nmap <buffer> M <Plug>(fern-action-rename:bottom)
  nmap <buffer> D <Plug>(fern-action-trash=)

  nmap <buffer> q :<C-u>quit<CR>

  " let s:guicuror_back = &guicursor
  " setlocal guicursor=n:hor25
  " au BufLeave fern setlocal guicursor=s:guicuror_back

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
  au! *
  au FileType fern call s:init_fern()
  " au VimEnter,WinEnter,BufWinEnter fern setlocal cursorline
  " au WinLeave fern setlocal nocursorline
augroup END

function! s:on_highlight() abort
  hi link FernRootSymbol Title
  hi link FernRootText   Title
endfunction

augroup my-fern-highlight
  autocmd!
  autocmd User FernHighlight call s:on_highlight()
augroup END

" let g:fern_git_status#disable_ignored = 1
" let g:fern_git_status#disable_untracked = 1
let g:fern_git_status#disable_submodules = 1
" let g:fern_git_status#disable_directories = 1

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
augroup END
