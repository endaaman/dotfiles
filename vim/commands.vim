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

function! LoadLocalVimConfig() abort
  if getcwd() == expand('~')
    return
  endif
  call SafeExec(getcwd() . '/.vim/init.vim')
endfunction
