let g:jupytext_enable = 1
" let g:jupytext_fmt = 'py:percent'
" let g:jupytext_filetype_map = { 'py': 'python' }
" let g:jupytext_filetype_map = {'py:percent': 'ipynb'}

" xmap <F5> <Plug>SlimeRegionSend
" nmap <F5> <Plug>SlimeParagraphSend
" let g:ipython_cell_regex = 1
" let g:ipython_cell_tag = '# %%( [^[].*)?'
" nnoremap <Space><C-j> :<C-u>IPythonCellExecuteCell<CR>

" let g:slime_no_mappings = 1
" let g:slime_python_ipython = 1
" let g:slime_cell_delimiter = '# %%'
" let g:slime_target = 'neovim'
" function SlimeOverrideConfig()
"   wincmd w
"   let l:chan = &channel
"   wincmd W
"   let b:slime_config = {
"     \ 'jobid': l:chan,
"     \ }
" endfunction
" let g:slime_dont_ask_default = 1

" let g:slime_default_config = {"sessionname": $STY, "windowname": "ipython3"}
