
"_vimrc - Zack Hixon, cheezgi at github
"last updated 2016-03-24

" maps {{{
filetype plugin on

if has('win32')
    let g:python3_host_prog='C:/Users/Zack/AppData/Local/Programs/Python/Python37/python.exe'
endif

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
iabbrev slef self
inoremap sle.f self.
inoremap sel.f self.

tmap jk <C-\><C-n>
tmap <Esc> <C-\><C-n>

let mapleader=" "
let maplocalleader="'"
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

nnoremap <leader>fs :w<cr>
nnoremap <leader>sf :w<cr>
nnoremap <leader>ch :noh<cr>
nnoremap <leader>bd :BD<cr>

nnoremap <leader>bb :CtrlPBuffer<cr>
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

" automatically read changed files
set autoread
set updatetime=1000
au CursorHold,CursorHoldI * checktime

" start in source folder
if has('win32')
    cd ~/source
endif

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
set tgc
set mouse=n
syntax on

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
" load plugin from local directory
fu s:local_plug(name) abort
    let loc = '~/source/' . a:name
    if isdirectory(expand(loc))
        execute "Plug '" . loc . "'"
    else
        echoerr 'directory ' . loc . ' does not exist'
    endif
endfu

if has('win32')
    call plug#begin('C:\Users\Zack\AppData\Local\nvim\plugged')
else
    call plug#begin('~/.config/nvim/plugged')
endif

" completion
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" highlighting
Plug 'sheerun/vim-polyglot'

" enhancements
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'qpkorr/vim-bufkill'

" ui
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'

" colorschemes
Plug 'chriskempson/base16-vim'
Plug 'AlessandroYorba/Alduin'
Plug 'mbbill/desertEx'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/edge'
Plug 'sainnhe/gruvbox-material'
call plug#end()
" }}}

" plugin config {{{
let g:rustfmt_autosave = 1

let g:gruvbox_material_background = 'medium'
set background=dark
colo gruvbox-material

let g:ctrlp_match_window='max:35'

" coc.nvim settings {{{
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

" true if there's space behind the cursor
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col-1] =~# '\s'
endfunction

" ctrl-space completion
inoremap <silent><expr> <c-space> coc#refresh()

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

" lightline w/ coc.nvim integration {{{
let g:lightline = {
            \ 'colorscheme': 'gruvbox_material',
            \ 'active': {
            \   'left': [
            \     ['mode', 'paste'],
            \     ['filename', 'readonly', 'modified', 'cocstatus']
            \   ],
            \ },
            \ 'component_function': {
            \   'cocstatus': 'coc#status'
            \ }
            \ }
" }}}
" }}}

" use tabs in gdscript3 files {{{
augroup GodotScriptTabs
    au!
    au FileType gdscript3 setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
    au FileType gdscript3 setlocal nolist
augroup END
" }}}

