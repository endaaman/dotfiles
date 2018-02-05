let g:lightline = {}
let g:lightline.enable = {
  \ 'statusline': 1,
  \ 'tabline': 1
  \ }
let g:lightline.colorscheme = 'hybrid'

let g:lightline.tabline = {
  \ 'left': [ [ 'tabs' ] ],
  \ 'right': [ [ ] ] }

let g:lightline.active = {}
let g:lightline.active.left = [
  \   [ 'mode', 'paste' ],
  \   [ 'dirname', 'filename' ],
  \ ]
let g:lightline.active.right = [
  \   [ 'syntastic', 'lineinfo' ],
  \   [ 'percent' ],
  \   [ 'indent', 'filetype' ],
  \ ]

let g:lightline.component_function = {
  \   'fugitive': 'LightLineFugitive',
  \   'dirname': 'LightlineDirname',
  \   'filename': 'LightlineFilename',
  \   'fileformat': 'LightlineFileformat',
  \   'filetype': 'LightlineFiletype',
  \   'fileencoding': 'LightlineFileencoding',
  \   'mode': 'LightlineMode',
  \   'indent': 'LightLineIndent',
  \ }

let g:lightline.component_expand = {
  \   'percent': 'LightLinePercent',
  \   'lineinfo': 'LightLineLineinfo',
  \ }

if exists('g:has_custom_font')
  " let g:lightline.separator = { 'left': '', 'right': '' }
  " let g:lightline.subseparator = { 'left': '|', 'right': '|' }
  " let g:lightline.separator = { 'left': '', 'right': '' }
  " let g:lightline.subseparator = { 'left': '', 'right': '' }
  " let g:lightline.separator = { 'left': '', 'right': '' }
  " let g:lightline.subseparator = { 'left': '', 'right': '' }
  let g:lightline.separator = { 'left': '', 'right': '' }
  let g:lightline.subseparator = { 'left': '', 'right': '' }
  " let g:lightline.separator = { 'left': '', 'right': '' }
  " let g:lightline.subseparator = { 'left': '', 'right': '' }
  " let g:lightline.separator = { 'left': '', 'right': '' }
  " let g:lightline.subseparator = { 'left': '', 'right': '' }
endif


function! LightLinePercent()
  " if &ft == 'nerdtree'
  "   return ''
  " endif
  return '%3p%%'
endfunction


function! LightLineLineinfo()
  if &ft == 'nerdtree'
    return ''
  endif
  return '%3l:%-2v'
endfunction


function! LightLineIndent()
  if &ft == 'nerdtree'
    return ''
  endif
  if &expandtab == 1
    return 'sw:' . &shiftwidth
  else
    return 'tab'
  endif
endfunction

function! LightLineFugitive()
  if &ft == 'nerdtree'
    return ''
  endif
  return exists('*fugitive#head') ?  fugitive#head() : ''
endfunction

function! LightlineDirname()
  if &ft == 'nerdtree' || winwidth(0) <= 80
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
  if &ft == 'nerdtree'
    return ''
  endif

  let fname = expand('%:t')
  if fname == ''
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
  if &ft == 'nerdtree'
    return 'NERD Tree'
  endif
  return lightline#mode()
endfunction
