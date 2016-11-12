function! IndentWithI()
  if len(getline('.')) == 0
    return 'cc'
  else
    return 'i'
  endif
endfunction

function! SwapWithAboveLine()
  if line('.') == 1
    return ''
  else
    return '"zddk"zP'
  endif
endfunction

noremap j gj
noremap k gk
noremap J <C-d>zz
noremap K <C-u>zz
" noremap J gjzz
" noremap K gkzz
" nnoremap <C-f> <C-d>zz
" nnoremap <C-b> <C-u>zz
noremap H ^
noremap L $
noremap m :
noremap x "_x

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap o o<Esc>
nnoremap O O<Esc>
nnoremap Y y$
nnoremap G Gzz
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap <C-a> ggVG
nnoremap <C-j> "zdd"zp
nnoremap <expr> <C-k> SwapWithAboveLine()
nnoremap <C-d> :<C-u>q<CR>
nnoremap <C-x> :<C-u>x<CR>
nnoremap <C-s> :<C-u>w<CR>
nnoremap <C-u> :<C-u>noh<CR>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap - <C-x>
nnoremap + <C-a>
nnoremap <Down> <C-x>
nnoremap <Up> <C-a>
nnoremap * viw"zy:<C-u>let @/ = @z\|set hlsearch<CR>

nnoremap <expr> i IndentWithI()

nnoremap <C-n> :<C-u>tabn<CR>
nnoremap <C-p> :<C-u>tabp<CR>
nnoremap <C-@> <C-l>

vnoremap v $h
vnoremap <Space> o
vnoremap * "zy:<C-u>let @/ = @z\|set hlsearch<CR>gv
vnoremap > >gv
vnoremap < <gv
" vnoremap p :<C-u>"0p<CR>

inoremap <BS> <Nop>
inoremap <C-l> <Del>
inoremap <C-s> <C-o>:<C-u>w<CR>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

nnoremap <C-m> :<C-u>source ~/.vimrc\|e!<CR>
nnoremap <C-c> <Nop>
nnoremap <C-h> <nop>
nnoremap <C-l> <nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <C-t> <Nop> " tmux prefix
nnoremap <C-y> <Nop> " Resizer
nnoremap <C-e> <Nop> " emmet

