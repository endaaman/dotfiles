function! CD() abort
  cd %:h
endfunction
command! CD :call CD()

function! LCD() abort
  lcd %:h
endfunction
command! LCD :call LCD()

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

function! SwapWithAboveLine() abort
  if line('.') == 1
    return ''
  else
    return '"zddk"zP'
  endif
endfunction

function! Chomp(string)
  return substitute(a:string, '\n\+$', '', '')
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

function! TrimTrailingSpaces() abort
  execute '%s/\s\+$//e'
endfunction
command! TrimTrailingSpaces :call TrimTrailingSpaces()

function! TrimTrailingTabs() abort
  execute '%s/\t\+$//e'
endfunction
command! TrimTrailingTabs :call TrimTrailingTabs()

function! MatchTrailingSpaces(cursor, ignores) abort
  for ft in a:ignores
    if ft ==# &filetype
      call clearmatches()
      return
    endif
  endfor
  if a:cursor
    match TrailingSpaces /\s\+\%#\@<!$/
  else
    match TrailingSpaces /\s\+$/
  endif
endfunction

function! TabMessage(cmd) abort
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr 'no output'
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
  if &clipboard =~? 'unnamedplus'
    silent let l:clipboard = getreg('+')
  elseif &clipboard =~? 'unnamed'
    let l:clipboard = getreg('*')
  else
    let l:clipboard = getreg('"')
  endif
  if l:clipboard ==# '' || l:clipboard ==# "\<NL>"
    return
  endif
  let l:list= ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']
  if @a != l:clipboard
    let l:i = len(l:list) - 1
    while l:i > -1
      call setreg(l:list[l:i], (l:i == 0 ? l:clipboard : getreg(l:list[l:i - 1])), 'v')
      let l:i -= 1
    endwhile
  endif
endfunction

function! RegisterPrefix(key) abort
  call ShiftRegister()
  return '"' . v:register . a:key
endfunction

function! EscapeHook() abort
  set nopaste
endfunction

function! LoadLocalVimConfig() abort
  if getcwd() == expand('~')
    return
  endif
  call SafeExec(getcwd() . '/.vim/init.vim')
endfunction

function! LoadFtConfig() abort
  call SafeExec(g:base_path . '/ft/default.vim')
  call SafeExec(g:base_path . '/ft/' . &filetype . '.vim')
  call SafeExec(getcwd() . '/.vim/' . &filetype . '.vim')
endfunction

function! YankFileName() abort
  let p = expand('%:t')
  let @+ = p
  echo 'yanked: ' . p
endfunction

function! YankRelativePath() abort
  let p = expand('%')
  let @+ = p
  echo 'yanked: ' . p
endfunction

function! YankFullPath() abort
  let p = expand('%:p')
  let @+ = p
  echo 'yanked: ' . p
endfunction

function! DeniteFileActionXdgOpen(context) abort
  execute '!xdg-open ' . a:context.targets[0].action__path
endfunction

function! s:xdg_open() abort
  execute '!xdg-open ' . expand('%:p')
endfunction
command! XdgOpen :call s:xdg_open()

function! DeniteWordActionPrepend(context) abort
  execute ':normal! i' . a:context.targets[0].action__text
endfunction

function! DeniteWordActionYank(context) abort
  call ShiftRegister()
  let l:text = a:context.targets[0].action__text
  call setreg('"', l:text ,'v')
  if has('clipboard')
    call setreg(v:register, l:text ,'v')
  endif
endfunction

function! DeniteActionTabopen(context) abort
  execute a:context.targets[0].action__command
  execute "normal! \<C-w>\T"
endfunction

function! DeniteActionQuitIfEmptyOrDelete() abort
  call denite#call_map('quit')
  " echom getline(1, '$')[0]
  return
  let l:lines = getline(1, '$')
  let l:is_empty = len(l:lines) > 0 && !empty(l:lines[0])
  if l:is_emptf
  endif
endfunction

function! DeniteCommonActionNop(context) abort
endfunction

function! s:compare_sign(a, b) abort
    return a:a['line_number'] - a:b['line_number']
endfunction

function! GetSigns(needle, reversed) abort
  redir => l:raw_signs
    silent execute 'sign place buffer=' . bufnr('%')
  redir END
  let l:signs = []
  for l:sign_line in filter(split(l:raw_signs, '\n')[2:], 'v:val =~# "="')
    let l:components  = split(l:sign_line)
    let l:name = split(l:components[2], '=')[1]
    if l:name =~# a:needle
      let l:line_number = str2nr(split(l:components[0], '=')[1])
      let l:id = str2nr(split(l:components[1], '=')[1])
      call add(l:signs, {
        \   'name': l:name,
        \   'id': l:id,
        \   'line_number': l:line_number,
        \ })
    endif
  endfor
  call sort(l:signs, 's:compare_sign')
  if a:reversed
    call reverse(l:signs)
  endif
  return l:signs
endfunction

function! s:jump_sign(needle, reversed) abort
  let l:line_number = line('.')
  for l:sign in GetSigns(a:needle, a:reversed)
    let l:diff = l:sign['line_number'] - l:line_number
    if a:reversed
      let l:diff = l:diff * -1
    endif
    if l:diff > 0
      execute 'normal! '. l:sign['line_number'] . 'Gzv'
      return
    endif
  endfor
  echohl WarningMsg
  echo 'No more signs'
  echohl None
endfunction

command! NeomakeNextSign :call s:jump_sign('neomake_file_', 0)
command! NeomakePrevSign :call s:jump_sign('neomake_file_', 1)
" command! CocNextSign :call s:jump_sign('Coc', 0)
" command! CocPrevSign :call s:jump_sign('Coc', 1)
command! CocNextSign :call CocAction('diagnosticNext')
command! CocPrevSign :call CocAction('diagnosticPrevious')

function! NeomakeSignCounts() abort
  let l:counts = { 'err': 0, 'warn': 0, 'info':0, 'msg': 0 }
  for l:sign in GetSigns('neomake_file_', 0)
    let l:key = substitute(l:sign['name'], 'neomake_file_', '', '')
    let l:counts[l:key] += 1
  endfor
  return l:counts
endfunction

function! s:format_xml() abort
  %s/></>\r</g
  filetype indent on
  setf xml
  normal gg=G
endfunction
command! FormatXml :call s:format_xml()
