let g:mapleader = ','

noremap <Space>j J
noremap <Space>i :<C-u>vs<CR>
noremap <Space>- :<C-u>sp<CR>
noremap <Space>e :<C-u>e!<CR>
noremap <Space><C-l> <C-l>
nnoremap <S-Left> :tabm -1<CR>
nnoremap <S-Right> :tabm +1<CR>
noremap <Space>q :<C-u>:q!<CR>
nnoremap <expr> <Space>/ SearchByRegister()

noremap j gj
noremap k gk
noremap J <C-d>zz
noremap K <C-u>zz
noremap H g^
noremap L g$
noremap gH ^
noremap gL $
nnoremap <BS> g;
" nnoremap <C-h> g;
" nnoremap <C-l> g,
noremap x "_x
noremap X "_D
noremap s "_s
nnoremap S "_S
noremap n nzz
noremap N Nzz
noremap G Gzz
" nnoremap <CR> yy
" vnoremap <CR> y
" nnoremap <silent> <expr> <CR> RegisterPrefix('yy')

nnoremap <expr> i IndentWithI()
nnoremap * :<C-u>let @/=expand("<cword>")\|set hlsearch<CR>
nnoremap <Space>w :<C-u>let @/=expand("<cword>")\|set hlsearch<CR>
nnoremap # #zz
nnoremap o o<Esc>
nnoremap O O<Esc>
nnoremap p p`]
nnoremap <S-Down> <C-x>
nnoremap <S-Up> <C-a>
nnoremap - <C-x>
nnoremap + <C-a>
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

nnoremap <C-y> <Nop>
nnoremap <C-e> <Nop>

nnoremap <Space>N :<C-u>lnext<CR>
nnoremap <Space>P :<C-u>lprev<CR>
" nnoremap <C-f> "zdd"zp
" nnoremap <expr> <C-b> SwapWithAboveLine()

nnoremap <C-a> ggVG
nnoremap <C-n> gt
nnoremap <C-Tab> gt
nnoremap <C-p> gT
nnoremap <C-S-Tab> gt
nnoremap <C-t> :<C-u>tabnew<CR>

nnoremap <C-u> :<C-u>noh<CR><C-l>
nnoremap <C-q> :<C-u>qa<CR>
nnoremap <C-d> :<C-u>q<CR>
nnoremap <C-x> :<C-u>x<CR>
nnoremap <C-s> :<C-u>w<CR>

vnoremap v $h
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap y y`]
vnoremap p <C-[>:<C-u>let @z=@+<CR>gvp`]:let @+=@z<CR>
vnoremap O :sort<CR>
vnoremap R c<C-O>:set revins<CR><C-R>"<Esc>:set norevins<CR>
vnoremap / "zy:<C-u>let @/=@z\|set hlsearch<CR>
vnoremap H ^
vnoremap L $
" vnoremap E "zy:<C-u><C-r>z<CR>

nnoremap <C-m> yy
vnoremap <C-m> y<Esc>

inoremap <C-d> <Del>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Delete>
nnoremap <C-l> <C-i>
nnoremap <C-h> <C-o>

nnoremap <silent> W :<C-u>MagicW<CR>
nnoremap <silent> B :<C-u>MagicB<CR>
noremap gW W
noremap gB B

nnoremap mm mA
nnoremap M 'A

" tnoremap <Esc> <C-\><C-n>
" tnoremap <C-Esc> <Esc>
" tnoremap <C-c> <C-\><C-n>
" tnoremap <Tab> <C-\><C-Tab><C-w>w

augroup QuickfixMapping
  autocmd!
  autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
  autocmd FileType qf nnoremap <buffer> o <C-w><CR>
augroup END
