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
  \ 'right': [ [ ] ]
  \ }

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
" let g:lightline.subseparator = { 'left': '', 'right': '' }
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }


function! LightLinePercent() abort
  " if &ft == 'nerdtree'
  "   return ''
  " endif
  return '%3p%%'
endfunction

function! LightLineLineinfo() abort
  if &ft == 'nerdtree'
    return ''
  endif
  return '%3l:%-2v'
endfunction

function! LightLineIndent() abort
  if &ft == 'nerdtree'
    return ''
  endif
  if &expandtab == 1
    return 'sw=' . &shiftwidth
  else
    return 'tab'
  endif
endfunction

function! LightLineFugitive() abort
  if &ft == 'nerdtree'
    return ''
  endif
  return exists('*fugitive#head') ?  fugitive#head() : ''
endfunction

function! LightlineDirname() abort
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

function! LightlineFilename() abort
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

function! LightlineBranch() abort
  return winwidth(0) > s:width_2 ? fugitive#head() : ''
endfunction

let s:neomake_marks = {
  \   'err': '',
  \   'warn': '',
  \   'info': '',
  \   'msg': '',
  \ }

function! LightlineNeomake() abort
  if !exists(':Neomake')
    return ''
  endif
  let running = neomake#statusline#get(bufnr('%'), {
    \ 'format_running': '… ({{running_job_names}})',
    \ })
  if running
    return running
  endif

  let l:counts = NeomakeSignCounts()
  let l:marks = []
  for l:k in keys(l:counts)
    if l:counts[l:k] > 0
      call add(l:marks, s:neomake_marks[l:k] . ':' . l:counts[l:k])
    endif
  endfor
  return len(l:marks) > 0 ? join(l:marks, ' ') : '✓'
endfunction

function! LightlineFileformat() abort
  return winwidth(0) > s:width_1 ? &fileformat : ''
endfunction

function! LightlineFiletype() abort
  return winwidth(0) > s:width_1 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding() abort
  return winwidth(0) > s:width_1 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode() abort
  if &ft == 'nerdtree'
    return winwidth(0) > s:width_0 ? 'NERD Tree' : 'NERD'
  endif
  let l:mode = lightline#mode()
  return winwidth(0) > s:width_1 ? l:mode : l:mode[0]
endfunction
