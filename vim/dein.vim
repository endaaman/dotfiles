let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if isdirectory(s:dein_repo_dir)
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

  call dein#begin(s:dein_dir)
  call dein#load_toml(expand('~/.vim/dein/common.toml'), {'lazy': 0})
  if has('nvim')
    call dein#load_toml(expand('~/.vim/dein/neovim.toml'), {'lazy': 0})
  else
    call dein#load_toml(expand('~/.vim/dein/vim.toml'), {'lazy': 0})
  endif
  call dein#end()
  call dein#save_state()

  if dein#check_install()
    call dein#install()
  endif

  filetype plugin indent on
endif
