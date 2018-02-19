mapclear

let g:mapleader = ','

noremap <Space>j J
noremap <Space>k K
noremap <Space>i :<C-u>vs<CR>
noremap <Space>- :<C-u>sp<CR>
noremap <Space>e :<C-u>e!<CR>
noremap <Space>l <C-l>
noremap <Space>s :s/
nnoremap <expr> <Space>/ SearchByRegister()

noremap j gj
noremap k gk
noremap J <C-d>zz
noremap K <C-u>zz
noremap <silent> <C-j> :<C-u>normal ]c<CR>
noremap <silent> <C-k> :<C-u>normal [c<CR>
noremap H g^
noremap L g$
nnoremap <BS> g;
nnoremap <C-h> g;
nnoremap <C-l> g,

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
nnoremap * *zz
nnoremap # #zz
nnoremap o o<Esc>
nnoremap O O<Esc>
nnoremap p p`]
nnoremap <C-f> "zdd"zp
nnoremap <expr> <C-b> SwapWithAboveLine()

nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

nnoremap <C-a> ggVG
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap <C-t> :<C-u>tabnew<CR>
nnoremap <Left> :tabm -1<CR>
nnoremap <Right> :tabm +1<CR>

nnoremap <C-u> :<C-u>noh<CR>
nnoremap <C-q> :<C-u>qa<CR>
nnoremap <C-d> :<C-u>q<CR>
nnoremap <C-x> :<C-u>x<CR>
nnoremap <C-s> :<C-u>w<CR>
nnoremap - <C-x>
nnoremap + <C-a>

vnoremap v $h
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap <C-m> y
vnoremap y y`]
vnoremap p <C-[>:<C-u>let @y=@+<CR>gvp`]:let @+=@y<CR>
vnoremap O :sort<CR>
vnoremap R c<C-O>:set revins<CR><C-R>"<Esc>:set norevins<CR>

command! ShiftRegister if @0 =~ "\<NL>"|let @9=@8|let @8=@7|let @7=@6|let @6=@5|let @5=@4|let @4=@3|let @3=@2|let @2=@1|let @1=@0|endif
nnoremap <silent>Y Y:<C-u>ShiftRegister<CR>
vnoremap <silent>Y Y:<C-u>ShiftRegister<CR>
vnoremap <silent>y y:<C-u>ShiftRegister<CR>
onoremap <silent>y y:<C-u>ShiftRegister<CR>
nnoremap <silent> <C-m> yy:<C-u>ShiftRegister<CR>
vnoremap <silent> <C-m> y:<C-u>ShiftRegister<CR>
onoremap <silent> <C-m> y:<C-u>ShiftRegister<CR>

inoremap <C-d> <Del>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Delete>
