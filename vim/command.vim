function! SaveAsRoot()
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

function g:reload_func_dict["_" . g:reload_count]()
  unlet g:reload_func_dict["_" . g:reload_count]
  delcommand ReloadConfig
  let g:reload_count = g:reload_count + 1
  execute 'source ~/.vim/command.vim'
  execute 'source ~/.vim/base.vim'
  execute 'source ~/.vim/keymap.vim'
  e!
  echo "Relaod count: " . g:reload_count
endfunction

command ReloadConfig :call g:reload_func_dict['_' . g:reload_count]()
