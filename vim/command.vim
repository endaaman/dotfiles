function! SafeExec(path) abort
  if filereadable(expand(a:path))
    execute 'source ' . a:path
  endif
endfunction
command! -nargs=+ SafeExec :call SafeExec(<f-args>)

function! LoadLocalVimConfig() abort
  if getcwd() == expand('~')
    return
  endif
  call SafeExec(getcwd() . '/.vim/init.vim')
endfunction


function! SaveAsRoot() abort
  w !sudo tee % > /dev/null
  e!
endfunction
command! SaveAsRoot :call SaveAsRoot()


if !exists("g:reload_count")
  let g:reload_count = 0
endif

if !exists("g:reload_func_dict")
  let g:reload_func_dict = {}
endif

function! g:reload_func_dict["_" . g:reload_count]() abort
  unlet g:reload_func_dict["_" . g:reload_count]
  delcommand ReloadConfig
  let g:reload_count = g:reload_count + 1
  execute 'source ~/.vim/general.vim'
  execute 'source ~/.vim/command.vim'
  execute 'source ~/.vim/keymap.vim'
  execute 'source ~/.vim/local.vim'
  e!
  echom "Relaod count: " . g:reload_count
endfunction

command ReloadConfig :call g:reload_func_dict['_' . g:reload_count]()
