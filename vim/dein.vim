let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

let s:toml_dir = expand('<sfile>:p:h') . '/dein'
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if isdirectory(s:dein_repo_dir)
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

  function! s:load(path) abort
    if filereadable(expand(a:path))
      call dein#load_toml(a:path, {})
    endif
  endfunction

  if !has('vim_starting')
    call dein#call_hook('source')
  endif

  call dein#begin(s:dein_dir)
  call s:load(s:toml_dir . '/general.toml')
  call s:load(s:toml_dir . '/nerdtree.toml')
  call s:load(s:toml_dir . '/syntax.toml')
  call s:load(s:toml_dir . '/appearance.toml')
  if has('nvim')
    call s:load(s:toml_dir . '/neovim.toml')
  else
    call s:load(s:toml_dir . '/vim.toml')
  endif
  call dein#end()
  call dein#save_state()

  if dein#check_install()
    call dein#install()
  endif

  if !has('vim_starting')
    call dein#call_hook('post_source')
  endif

  syntax enable
  filetype plugin indent on

  command! DeinUpdate :call dein#update()
  command! DeinRecache :call dein#recache_runtimepath()
endif
