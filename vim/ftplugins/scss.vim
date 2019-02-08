function! FtPluginSASS() abort
  setlocal iskeyword+=-
endfunction

autocmd EN FileType sass,scss call FtPluginSASS()
