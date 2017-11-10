" set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
"
" autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
