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
noremap <Space>s :s/
nnoremap <Space>e :<C-u>e!<CR>
nnoremap <Space>d g0"_D
nnoremap <expr> <Space>/ SearchByRegister()

nnoremap <expr> <Space><Space><Space><Space> ReloadConfigAndReopen()

"
noremap j gj
noremap k gk
noremap J <C-d>zz
noremap K <C-u>zz
noremap H ^
noremap L $
noremap <C-b> %
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
nnoremap <C-a> ggVG
nnoremap <C-j> "zdd"zp
nnoremap <expr> <C-k> SwapWithAboveLine()
nnoremap <C-u> :<C-u>noh<CR>
nnoremap <C-q> :<C-u>qa<CR>
nnoremap <C-d> :<C-u>q<CR>
nnoremap <C-x> :<C-u>x<CR>
nnoremap <C-s> :<C-u>w<CR>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap - <C-a>
nnoremap + <C-x>
nnoremap <Down> <C-x>
nnoremap <Up> <C-a>
nnoremap <C-t> :<C-u>tabnew<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap <Left> :tabm -1<CR>
nnoremap <Right> :tabm +1<CR>
nnoremap <C-@> <C-l>

nnoremap * viw"zy:<C-u>let @/=@z\|set hlsearch<CR>n
nnoremap <expr> i IndentWithI()

vnoremap v $h
vnoremap * "zy:<C-u>let @/=@z\|set hlsearch<CR>gv
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap y y`]
vnoremap p <C-[>:<C-u>let @y=@+<CR>gvp`]:let @+=@y<CR>
vnoremap O V:sort<CR>

inoremap <C-d> <Del>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" unsed
nnoremap <C-o> <Nop>
nnoremap <C-m> <Nop>
nnoremap <C-q> <Nop>
nnoremap <C-y> <Nop>
nnoremap <C-e> <Nop>

if has('nvim')
  nnoremap <Space>t :<C-u>tabnew\|terminal<CR>
  tnoremap <silent> <ESC> <C-\><C-n>
endif

