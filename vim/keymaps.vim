mapclear

let g:mapleader = ','

nnoremap <silent> <Esc> <Esc>:<C-u>call EscapeHook()<CR>

noremap <Space>j J
" noremap <Space>K K
nmap <Space>k <Plug>(go-to-def)
nmap <Space>K <Plug>(go-to-def-tab)
noremap <Space>i :<C-u>vs<CR>
noremap <Space>- :<C-u>sp<CR>
noremap <Space>e :<C-u>e!<CR>
noremap <Space>L <C-l>
noremap <Space>t :<C-u>terminal<CR>
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
noremap c "_c
noremap C "_C
noremap s "_s
nnoremap S "_S
noremap n nzz
noremap N Nzz
noremap G Gzz

nnoremap <expr> i IndentWithI()
nnoremap * :<C-u>let @/=expand("<cword>")\|set hlsearch<CR>
nnoremap <Space>w :<C-u>let @/=expand("<cword>")\|set hlsearch<CR>
nnoremap # #zz
nnoremap o o<Esc>
nnoremap O O<Esc>
nnoremap p p`]
nnoremap M :<C-u>call AutoMarkrement()<CR>
nnoremap - <C-x>
nnoremap + <C-a>
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

nnoremap <C-y> <Nop>
nnoremap <C-e> <Nop>

nnoremap <C-l> <C-i>
nnoremap <C-h> <C-o>
nnoremap <Space>N :<C-u>lnext<CR>
nnoremap <Space>P :<C-u>lprev<CR>
" nnoremap <C-f> "zdd"zp
" nnoremap <expr> <C-b> SwapWithAboveLine()

nnoremap <C-a> ggVG
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap <C-t> :<C-u>tabnew<CR>
nnoremap <Left> :tabm -1<CR>
nnoremap <Right> :tabm +1<CR>

nnoremap <C-u> :<C-u>noh<CR><C-l>
nnoremap <C-q> :<C-u>qa<CR>
nnoremap <C-d> :<C-u>q<CR>
nnoremap <C-x> :<C-u>x<CR>
nnoremap <C-s> :<C-u>w<CR>

vnoremap v $h
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap y y`]
vnoremap p <C-[>:<C-u>let @y=@+<CR>gvp`]:let @+=@y<CR>
vnoremap O :sort<CR>
vnoremap R c<C-O>:set revins<CR><C-R>"<Esc>:set norevins<CR>
vnoremap / "zy:<C-u>let @/=@z\|set hlsearch<CR>

nnoremap <silent>Y :<C-u>ShiftRegister<CR>Y
vnoremap <silent>Y :<C-u>ShiftRegister<CR>y
vnoremap <silent>y :<C-u>ShiftRegister<CR>y
onoremap <silent>y :<C-u>ShiftRegister<CR>y
nnoremap <silent> <C-m> :<C-u>ShiftRegister<CR>yy
vnoremap <silent> <C-m> :<C-u>ShiftRegister<CR>gvy
onoremap <silent> <C-m> :<C-u>ShiftRegister<CR>y

inoremap <C-d> <Del>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Delete>
