function! SwapWithAboveLine()
  if line('.') == 1
    return ''
  else
    return '"zddk"zP'
  endif
endfunction

function! IndentWithI()
  if len(getline('.')) == 0
    return 'cc'
  else
    return 'i'
  endif
endfunction

function! SearchByRegister()
  let splitted = split(@+, '\n')
  if 0 < len(splitted)
    let @/ = splitted[0]
    return 'n'
  else
    return ''
  endif
endfunction

function! PickExecutable(pathspecs) abort
  for pathspec in filter(a:pathspecs, '!empty(v:val)')
    for path in reverse(glob(pathspec, 0, 1))
      if executable(path)
        return path
      endif
    endfor
  endfor
  return ''
endfunction

let g:log_file_path = '/tmp/vimrc.log'
function! Log(line)
  execute ":redir! >> " . g:log_file_path
  silent! echon a:line . "\n"
  redir END
endfun

call Log('')
call Log('[vim started]\n')
