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

function! SearchByRegister()
  let splitted = split(@+, '\n')
  if 0 < len(splitted)
    let @/ = splitted[0]
    return 'n'
  else
    return ''
  endif
endfunction

let g:mapleader = "\<Space>"

noremap <Space>j J
noremap <Space>k K
noremap <Space>n <C-i>
noremap <Space>p <C-o>
noremap <Space>l :<C-u>nohlsearch<CR><C-l>
noremap <Space>i :<C-u>vs<CR>
noremap <Space>- :<C-u>sp<CR>
noremap <Space>s :s/
nnoremap <Space>e :<C-u>e!<CR>
nnoremap <Space>d g0"_D
nnoremap <expr> <Space>/ SearchByRegister()

nnoremap <expr> <Space><Space><Space><Space> ReloadConfigAndReopen()

noremap j gj
noremap k gk
noremap J <C-d>zz
noremap K <C-u>zz
noremap H ^
noremap L $
noremap <C-Space> zz
noremap x "_x
noremap c "_c
noremap C "_C
noremap s "_s
noremap S "_S
noremap n nzz
noremap N Nzz
noremap G Gzz

nnoremap * *zz
nnoremap # #zz
nnoremap o o<Esc>
nnoremap O O<Esc>
nnoremap p p`]
nnoremap Y y$

nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap <C-o> gf
nnoremap <C-h> <C-w>h
nnoremap <BS> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-f> "zdd"zp
nnoremap <expr> <C-b> SwapWithAboveLine()
nnoremap <C-m> yy
nnoremap <CR> yy
nnoremap = <C-w>=

nnoremap <C-a> ggVG
nnoremap <C-u> :<C-u>noh<CR>
nnoremap <C-q> :<C-u>qa<CR>
nnoremap <C-d> :<C-u>q<CR>
nnoremap <C-x> :<C-u>x<CR>
nnoremap <C-s> :<C-u>w<CR>
nnoremap <C-t> :<C-u>tabnew<CR>
nnoremap - <C-a>
nnoremap + <C-x>
nnoremap <Left> :tabm -1<CR>
nnoremap <Right> :tabm +1<CR>
nnoremap * viw"zy:<C-u>let @/=@z\|set hlsearch<CR>
nnoremap <expr> i IndentWithI()

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

vnoremap v $h
vnoremap * "zy:<C-u>let @/=@z\|set hlsearch<CR>
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap y y`]
vnoremap p <C-[>:<C-u>let @y=@+<CR>gvp`]:let @+=@y<CR>
vnoremap O :sort<CR>
vnoremap <C-m> y

inoremap <C-d> <Del>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" unsed
nnoremap <C-q> <Nop>
nnoremap <C-y> <Nop>
nnoremap <C-e> <Nop>

if has('nvim')
  nnoremap <Space>t :<C-u>tabnew\|terminal<CR>
  tnoremap <silent> <ESC> <C-\><C-n>
endif

