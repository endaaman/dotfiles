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

function! PutTextWithoutOverrideRegister()
  let line_len = strlen(getline('.'))
  execute "normal! `>"
  let col_loc = col('.')
  execute 'normal! gv"_x'
  if line_len == col_loc
    execute 'normal! p'
  else
    execute 'normal! P'
  endif
endfunction


let g:mapleader = "\<Space>"

noremap <Leader>s :s/
noremap <Leader>j J
noremap <Leader>k K
noremap <Leader><space> zz
nnoremap <Leader>i gg=G<C-o><C-o>zz
nnoremap <Leader>e :<C-u>e!<CR>
nnoremap <Leader>v g0v$h
nnoremap <Leader>d g0"_D
nnoremap <Leader>/ :<C-u>let @/ = @0\|set hlsearch<CR>

noremap j gj
noremap k gk
noremap J <C-d>zz
noremap K <C-u>zz
noremap H ^
noremap L $
noremap x "_x
noremap c "_c
noremap C "_C
noremap s "_s
noremap S "_S


nnoremap p p`]
vnoremap y y`]
" vnoremap p "_x`<p`]
" vnoremap p :<C-u>call PutTextWithoutOverrideRegister()<CR>


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
nnoremap <C-m> <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap - <C-a>
nnoremap + <C-x>
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

inoremap <C-d> <Del>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
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

