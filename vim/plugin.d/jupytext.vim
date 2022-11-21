

let g:jupytext_enable = 1
" セルの区切り文字をVSCode互換の # %% に指定する
let g:jupytext_fmt = 'py:percent'

" vimのPython向けシンタックスハイライトを有効にする
let g:jupytext_filetype_map = {'py:percent': 'ipynb'}

" xmap <F5> <Plug>SlimeRegionSend
" nmap <F5> <Plug>SlimeParagraphSend
let g:ipython_cell_regex = 1
let g:ipython_cell_tag = '# %%( [^[].*)?'
nnoremap <Space><C-j> :<C-u>IPythonCellExecuteCell<CR>

let g:slime_no_mappings = 1

" ipythonを使う
let g:slime_python_ipython = 1
" セルの区切り文字を指定
let g:slime_cell_delimiter = '# %%'

" TMUX
" let g:slime_target = 'tmux'
" let g:slime_default_config = {
"   \ 'socket_name': get(split($TMUX, ','), 0),
"   \ 'target_pane': '{right-of}' }

" NeoVim terminal
let g:slime_target = 'neovim'
function SlimeOverrideConfig()
  wincmd w
  let l:chan = &channel
  wincmd W
  let b:slime_config = {
    \ 'jobid': l:chan,
    \ }
endfunction
" let g:slime_dont_ask_default = 1

" " 環境変数 $STY から GNU Screen のセッション名を取得する
" let g:slime_default_config = {"sessionname": $STY, "windowname": "ipython3"}

