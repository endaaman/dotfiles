function! FtPluginC() abort
  setlocal cinoptions=p0,t0,:N,=0 |
  setlocal cinwords=if,else,switch,case,for,while,do |
  setlocal cindent
  nmap <Plug>(go-to-def) <C-]>
endfunction

autocmd EN FileType c call FtPluginC()
