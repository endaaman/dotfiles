function! SaveAsRoot() abort
  w !sudo tee % > /dev/null
  e!
endfunction
command! SaveAsRoot :call SaveAsRoot()

function! IndentWithI() abort
  if len(getline('.')) == 0
    return '"_cc'
  else
    return 'i'
  endif
endfunction

function! SearchByRegister() abort
  let splitted = split(@+, '\n')
  if 0 < len(splitted)
    let @/ = splitted[0]
    return 'n'
  else
    return ''
  endif
endfunction
