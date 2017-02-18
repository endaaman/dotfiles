function! SaveAsRoot()
  w !sudo tee % > /dev/null
  e!
endfunction


function! ReloadConfigAndReopen()
  if has('nvim')
    let config = '~/.config/nvim/init.vim'
  else
    let config = '~/.vimrc'
  endif
  execute 'source ' . config
  e!
endfunction


command! SaveAsRoot :call SaveAsRoot()
command! ReloadConfig :call ReloadConfig()
