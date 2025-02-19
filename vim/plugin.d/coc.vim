finish

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

" let g:coc_enable_locationlist = 0
" autocmd User CocLocationsChange
" CocList --normal location

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> <C-o> :call <SID>show_documentation()<CR>
nmap <Space>kk <Plug>(coc-definition))

let g:coc_node_path = Chomp(system('which node'))
call coc#config('python.jediEnabled', 1)
" let cmd = 'python3 -c "import site; print(site.getsitepackages()[0])"'
" let g:site_packages_path = split(Chomp(system(l:cmd)))[-1]
" call coc#config('python.jediPath', g:site_packages_path)
" call coc#config('python.pythonPath', Chomp(system('which python')))
call coc#config('python.poetryPath', Chomp(system('which poetry')))
" call coc#config('python.venvPath', '~/.cache/pypoetry/virtualenvs')

" command! JumpToDefinitionInNewTab :tabedit % | call CocAction('jumpDefinition')
command! JumpToDefinitionInNewTab call CocAction('jumpDefinition')
nnoremap <silent> <Space>K :<C-u>JumpToDefinitionInNewTab<CR>
nmap <Space>kt <Plug>(coc-type-definition)
nmap <Space>ki <Plug>(coc-implementation)
nmap <Space>kr <Plug>(coc-references)
nnoremap <C-f> :<C-u>CocNextSign<CR>
nnoremap <C-b> :<C-u>CocPrevSign<CR>


set updatetime=300
au CursorHold * sil call CocActionAsync('highlight')
" au CursorHoldI * sil call CocActionAsync('showSignatureHelp')

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ pumvisible() ? "\<C-n>" :
  \ CheckBackSpace() ? "\<TAB>" :
  \ coc#refresh()

inoremap <silent><expr> <S-TAB>
  \ coc#pum#visible() ? coc#pum#prev(1):
  \ pumvisible() ? "\<C-p>" :
  \ coc#refresh()

inoremap <silent><expr> <C-o> CocActionAsync('showSignatureHelp')
