
"_vimrc - Zack Hixon, cheezgi at github
"last updated 2016-03-24

" maps {{{
filetype plugin on
" let nvim use python
"let g:python_host_prog='C:/Python27/python.exe'
let g:python3_host_prog='C:/Users/Zack/AppData/Local/Programs/Python/Python37/python.exe'

" turn off bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" toggle cursor column
set nocuc
fu! CursorColumn()
    if &cuc
        set nocuc
    else
        set cuc
    endif
endfu
map <silent> <M-p> :call CursorColumn()<cr>

nmap <silent> <F5> :checktime<cr>

inoremap jk <Esc>
inoremap slef self
inoremap sle.f self.
inoremap sel.f self.

" key mappings
let mapleader=" "
let maplocalleader="'"
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

nnoremap <leader>fs :w<cr>
nnoremap <leader>sf :w<cr>
nnoremap <leader>ch :noh<cr>
nnoremap <leader>bd :BD<cr>

nnoremap <leader>bb :CtrlPBuffers<cr>
nnoremap <leader>ff :CtrlP<cr>

nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>w/ :vne<cr>
nnoremap <leader>wd :q<cr>
nnoremap <leader>wn :new<cr>
" }}}

" configs {{{
" don't create junk files
set noswapfile

" automatically read changed files
set autoread
set updatetime=1000
au CursorHold,CursorHoldI * checktime

" start in source folder
cd ~/source

" highlight 80th column
highlight ColorColumn guibg=LightMagenta
call matchadd('ColorColumn', '\%81v', 100)

" keep 6 lines above and below the cursor at all times
set scrolloff=6

" mark folds
set fdm=marker

" show trailing whitespace, tabs
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" graphical settings
set number
set relativenumber
set cursorline
set nowrap
set nospell
set noshowmode
set noequalalways
set inccommand=nosplit

" 4 spaces, no tab characters
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" formatting
set formatoptions-=t
set textwidth=0 wrapmargin=0
set tw=0
set fileformats=unix

"neovide
let g:neovide_refresh_rate = 144
let g:neovide_cursor_animation_length = 0.08
let g:neovide_cursor_trail_length = 0.2
" }}}

" plugins {{{
call plug#begin('C:\Users\Zack\AppData\Local\nvim\plugged')

" completion
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" highlighting
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'tikhomirov/vim-glsl'
Plug 'gabrielelana/vim-markdown'

" enhancements
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'qpkorr/vim-bufkill'

" ui
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

" colorschemes
Plug 'chriskempson/base16-vim'
Plug 'AlessandroYorba/Alduin'
Plug 'mbbill/desertEx'
call plug#end()
" }}}

" plugin config {{{
let g:rustfmt_autosave = 1

colo base16-gruvbox-dark-hard
let g:airline_theme='base16_gruvbox_dark_hard'

let g:ctrlp_match_window='max:35'

" coc.nvim settings
set hidden
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" tab insert
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" dot completion
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col-1] =~# '\s'
endfunction

" ctrl-space completion
inoremap <silent><expr> <c-space> coc#refesh()

if exists('*complete_info')
    inoremap <expr><cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u<CR>"
else
    inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" next/prev error messages
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" jump to definition/implementation
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" show docs
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" show docs on hover
autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}

