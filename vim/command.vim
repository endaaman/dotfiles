function! SaveAsRoot()
  w !sudo tee % > /dev/null
  e!
endfunction
command! SaveAsRoot :call SaveAsRoot()


function! ReloadConfigAndReopen()
  if has('nvim')
    let config = '~/.config/nvim/init.vim'
  else
    let config = '~/.vimrc'
  endif
  execute 'source ' . config
  e!
endfunction
command! ReloadConfig :call ReloadConfig()
