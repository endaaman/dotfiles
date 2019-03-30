function! SafeExec(path) abort
  if filereadable(expand(a:path))
    execute 'source ' . a:path
  endif
endfunction
command! -nargs=+ SafeExec :call SafeExec(<f-args>)

function! SaveAsRoot() abort
  w !sudo tee % > /dev/null
  e!
endfunction
command! SaveAsRoot :call SaveAsRoot()

function! TrimTrailingSpaces() abort
  " if matchstr(&ft, '\(markdown\|pug\)') != ''
  "   return
  " endif
  %s/\s\+$//e
endfunction
command! TrimTrailingSpaces :call TrimTrailingSpaces()

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

function! MatchTrailingSpaces(cursor, ignores) abort
  for ft in a:ignores
    if ft ==# &filetype
      call clearmatches()
      return
    endif
  endfor
  if a:cursor
    match ExtraWhitespace /\s\+\%#\@<!$/
  else
    match ExtraWhitespace /\s\+$/
  endif
endfunction

function! TabMessage(cmd) abort
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
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

if !exists('g:markrement_char')
  let g:markrement_char = [
    \   'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \   'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
function! AutoMarkrement() abort
  if !exists('b:markrement_pos')
    let b:markrement_pos = 0
  else
    let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
  endif
  execute 'mark' g:markrement_char[b:markrement_pos]
  echo 'marked' g:markrement_char[b:markrement_pos]
endfunction

function! ShiftRegister() abort
  if &clipboard =~ 'unnamedplus'
    let l:clipboard = @+
  elseif &clipboard =~ 'unnamed'
    let l:clipboard = @*
  else
    let l:clipboard = @"
  endif

  if l:clipboard == ''
    return
  endif

  if @1 != l:clipboard
    let @9 = @8
    let @8 = @7
    let @7 = @6
    let @6 = @5
    let @5 = @4
    let @4 = @3
    let @3 = @2
    let @2 = @1
    let @1 = l:clipboard
  endif
endfunction
command! ShiftRegister :call ShiftRegister()

function! EscapeHook() abort
  set nopaste
endfunction

function! LoadLocalVimConfig() abort
  if getcwd() == expand('~')
    return
  endif
  call SafeExec(getcwd() . '/.vim/init.vim')
endfunction

function! LoadFtConig() abort
  call SafeExec(g:base_path . '/ft/default.vim')
  call SafeExec(g:base_path . '/ft/' . &ft . '.vim')
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

function! DeniteActionXdgOpen(context) abort
  execute '!xdg-open ' . a:context.targets[0].action__path
endfunction

function! DeniteActionPrepend(context) abort
  execute ":normal i" . a:context.targets[0].action__text
endfunction

function! DeniteActionTabopen(context) abort
  execute a:context.targets[0].action__command
  execute "normal \<C-w>\T"
endfunction
