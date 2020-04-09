let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

let s:toml_dir = expand('<sfile>:p:h') . '/dein'
let s:dein_repo_dir = g:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

function! s:update() abort
  call dein#clear_state()
  call dein#update()
endfunction
command! DeinUpdate :call s:update()

function! s:recache() abort
  call dein#clear_state()
  call dein#recache_runtimepath()
endfunction
command! DeinRecache :call s:recache()

function! s:load(path) abort
  if filereadable(expand(a:path))
    call dein#load_toml(a:path, {})
  else
    echom 'Not found: ' . a:path
  endif
endfunction

if dein#load_state(s:dein_repo_dir)
  call dein#begin(g:dein_dir)
  call s:load(s:toml_dir . '/general.toml')
  if get(g:, 'rich')
    call s:load(s:toml_dir . '/rich.toml')
  endif
  call s:load(s:toml_dir . '/syntax.toml')
  call s:load(s:toml_dir . '/appearance.toml')
  call s:load(s:toml_dir . '/nvim.toml')
  if !has('nvim')
    call s:load(s:toml_dir . '/vim.toml')
  endif
  call dein#end()

  call dein#save_state()
  if dein#check_install()
    call dein#install()
  endif
  " if has('nvim')
  "   call dein#remote_plugins()
  " endif

  colorscheme iceberg

  function! ReloadHook() abort
    echom 'reload hook'
    call dein#source()
    if exists('*webdevicons#refresh')
      call webdevicons#refresh()
    endif
    set tabline=%!lightline#tabline()
  endfunction
  if get(g:, 'loaded_webdevicons')
    call webdevicons#refresh()
  endif
endif
