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

function! DeleteLineWithoutBreak()

  if getline('.') == ''
    return ''
  else
    return '^v$hx'
  endif
endfunction



let mapleader = "\<Space>"

nnoremap <Leader>i gg=G<C-o><C-o>zz
nnoremap <Leader>e :<C-u>e!<CR>
nnoremap <Leader>u :<C-u>:noh<CR>
nnoremap <expr> <Leader>d DeleteLineWithoutBreak()

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
noremap x "_x
noremap c "_c
noremap C "_C
noremap s "_s
noremap S "_S

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
nnoremap <C-u> :<C-u>noh<CR>
nnoremap <C-q> :<C-u>qa<CR>
nnoremap <C-d> :<C-u>q<CR>
nnoremap <C-x> :<C-u>x<CR>
nnoremap <C-s> :<C-u>w<CR>
nnoremap <C-m> zz
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap - <C-x>
nnoremap + <C-a>
nnoremap <Down> <C-x>
nnoremap <Up> <C-a>
nnoremap * viw"zy:<C-u>let @/ = @z\|set hlsearch<CR>

nnoremap <expr> i IndentWithI()

nnoremap <C-t> :<C-u>tabnew<CR>
nnoremap <C-n> :<C-u>tabn<CR>
nnoremap <C-p> :<C-u>tabp<CR>
nnoremap <C-@> <C-l>

vnoremap v $h
vnoremap <Space> o
vnoremap * "zy:<C-u>let @/ = @z\|set hlsearch<CR>gv
vnoremap > >gv
vnoremap < <gv
" vnoremap p :<C-u>"0p<CR>

inoremap <C-l> <Del>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <C-q> <Nop> "tmux prefix
nnoremap <C-y> <Nop> "Resizer
nnoremap <C-e> <Nop> "emmet


if has('nvim')
  nnoremap <Leader>r :<C-u>source ~/.config/nvim/init.vim\|e!<CR>
else
  nnoremap <Leader>r :<C-u>source ~/.vimrc\|e!<CR>
endif
