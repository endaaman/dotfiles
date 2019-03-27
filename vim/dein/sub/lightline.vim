let s:width_0 = 40
let s:width_1 = 80
let s:width_2 = 120

let g:lightline = {}

let g:lightline.enable = {
  \ 'statusline': 1,
  \ 'tabline': 1
  \ }

let g:lightline.tabline = {
  \ 'left': [ [ 'tabs' ] ],
  \ 'right': [ [ ] ] }

let g:lightline.active = {}
let g:lightline.active.left = [
  \   [ 'mode', 'paste' ],
  \   [ 'dirname', 'filename' ],
  \   [ 'branch', 'neomake' ],
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
  \   'branch': 'LightlineBranch',
  \   'neomake': 'LightlineNeomake',
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

" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '|', 'right': '|' }
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }


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
  if &ft == 'nerdtree' || winwidth(0) <= s:width_1
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

function! LightlineBranch()
  return winwidth(0) > s:width_2 ? fugitive#head() : ''
endfunction

function! LightlineNeomake()
  let running = neomake#statusline#get(bufnr('%'), {
    \ 'format_running': '… ({{running_job_names}})',
    \ })
  if running
    return running
  endif
  let mm = []
  let stats = neomake#statusline#LoclistCounts()
  if has_key(stats, 'E')
    call add(mm, ':' . stats['E'])
  endif
  if has_key(stats, 'W')
    call add(mm, ':' . stats['W'])
  endif
  if has_key(stats, 'x')
    call add(mm, 'x:' . stats['x'])
  endif
  if len(mm)
    return join(mm, ' ')
  else
    return '✓'
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > s:width_1 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > s:width_1 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > s:width_1 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  if &ft == 'nerdtree'
    return winwidth(0) > s:width_0 ? 'NERD Tree' : 'NERD'
  endif
  let l:mode = lightline#mode()
  return winwidth(0) > s:width_1 ? l:mode : l:mode[0]
endfunction
