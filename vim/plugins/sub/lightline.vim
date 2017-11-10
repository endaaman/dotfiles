let g:lightline = {}
let g:lightline.colorscheme = 'hybrid'

let g:lightline.active = {}
let g:lightline.active.left = [
\   [ 'mode', 'paste' ],
\   [ 'dirname', 'filename' ],
\ ]
let g:lightline.active.right = [
\   [ 'syntastic', 'lineinfo' ],
\   [ 'percent' ],
\   [ 'fugitive', 'fileformat', 'fileencoding', 'filetype' ],
\ ]

let g:lightline.component_function = {
\   'fugitive': 'LightLineFugitive',
\   'dirname': 'LightlineDirname',
\   'filename': 'LightlineFilename',
\   'fileformat': 'LightlineFileformat',
\   'filetype': 'LightlineFiletype',
\   'fileencoding': 'LightlineFileencoding',
\   'mode': 'LightlineMode',
\ }

" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '|', 'right': '|' }

let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

function! LightLineFugitive()
  let fname = expand('%:t')
  if fname =~ 'NERD_tree'
    return ''
  endif
  return exists('*fugitive#head') ? '' . fugitive#head() : ''
endfunction

function! LightlineDirname()
  let fname = expand('%:t')
  if fname =~ 'NERD_tree' || winwidth(0) <= 80
    return ''
  endif

  let dirname = expand('%:h')
  if dirname[0] == '/'
    return dirname
  elseif dirname == '.'
    return './'
  else
    return './' . dirname
  endif
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  if fname =~ 'NERD_tree'
    let fname = ''
  elseif fname == ''
    let fname = '[No Name]'
  endif
  return
    \ (&readonly ? ' ' : '') .
    \ fname .
    \ (&modified ? ' +' : '')
endfunction

function! LightlineFileformat()
  return winwidth(0) > 80 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 80 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 80 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  if fname =~ 'NERD_tree'
    return 'NERD Tree'
  endif
  return lightline#mode()
endfunction
