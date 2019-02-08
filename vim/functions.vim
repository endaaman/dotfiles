function! TrimTrailingSpaces() abort
  if matchstr(&ft, '\(markdown\|pug\)') != ''
    return
  endif
  %s/\s\+$//e
endfunction

" function! SearchByCurrentWord() abort
"   let @/ = expand("<cword>")
"   set hlsearch
" endfunction

function! SwapWithAboveLine() abort
  if line('.') == 1
    return ''
  else
    return '"zddk"zP'
  endif
endfunction

function! IndentWithI() abort
  if len(getline('.')) == 0
    return 'cc'
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

function! YankFileName() abort
  let p = expand('%:t')
  let @+ = p
  echo "yanked: " . p
endfunction

function! YankRelativePath() abort
  let p = expand('%')
  let @+ = p
  echo "yanked: " . p
endfunction

function! YankFullPath() abort
  let p = expand('%:p')
  let @+ = p
  echo "yanked: " . p
endfunction

function! DeniteActionXdgOpen(context)
  execute '!xdg-open ' . a:context.targets[0].action__path
endfunction

function! DeniteActionPrepend(context)
  execute ":normal i" . a:context.targets[0].action__text
endfunction

function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    tabnew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction

if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
function! AutoMarkrement()
  if !exists('b:markrement_pos')
    let b:markrement_pos = 0
  else
    let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
  endif
  execute 'mark' g:markrement_char[b:markrement_pos]
  echo 'marked' g:markrement_char[b:markrement_pos]
endfunction
