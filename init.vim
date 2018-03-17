
"_vimrc - Zack Hixon, cheezgi at github
"last updated 2016-03-24

" maps {{{

" let nvim use python
let g:python_host_prog='C:/Python27/python.exe'
let g:python3_host_prog='C:/Users/Zack/AppData/Local/Programs/Python/Python36-32/python.exe'

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

" key mappings
let mapleader=" "
let maplocalleader="'"
nmap <silent> <C-l> :noh<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <leader>sf :so %<cr>
nnoremap <leader>fs :w<cr>
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>w/ :vne<cr>
nnoremap <leader>wn :new<cr>
nnoremap <leader>ch :noh<cr>
nnoremap <leader>bd :bd<cr>
nnoremap <leader>bb :FufBuffer<cr>
nnoremap <leader>ff :FufFile<cr>

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
set synmaxcol=150
set nospell
set noshowmode

" 4 spaces, no tab characters
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" formatting
set formatoptions-=t
set textwidth=0 wrapmargin=0
set tw=0
set fileformat=unix
set fileformats=unix,dos

" }}}

" plugins {{{
call plug#begin('C:\Users\Zack\AppData\Local\nvim\plugged')

" completion
"Plug 'scrooloose/syntastic'
"Plug 'racer-rust/vim-racer'
"Plug 'junegunn/fzf'
"Plug 'roxma/nvim-cm-racer'
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': './install.ps1',
            \ }
"Plug 'Valloric/YouCompleteMe'
Plug 'roxma/nvim-completion-manager'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim'
"Plug 'sebastianmarkow/deoplete-rust'
"Plug 'zchee/deoplete-go', {'build:': 'make'}
"Plug 'zchee/deoplete-jedi'
"Plug 'zchee/deoplete-clang'
"Plug 'honza/vim-snippets'
"Plug 'SirVer/ultisnips'

" highlighting
Plug 'rust-lang/rust.vim'
"Plug 'benbrunton/vl.vim'
"Plug 'daveyarwood/vim-alda'
"Plug 'vim-scripts/arnoldc.vim'
Plug 'cespare/vim-toml'
"Plug 'scooter-dangle/vim-factor'

" enhancements
Plug 'itchyny/lightline.vim'
Plug 'ernstki/FuzzyFinder'
Plug 'vim-scripts/L9'
"Plug 'vim-scripts/LycosaExplorer'
"Plug 'vim-scripts/incbufswitch.vim'
"Plug 'jlanzarotta/bufexplorer'
"Plug 'jceb/vim-orgmode'
"Plug 'tpope/vim-abolish'
"Plug 'tpope/vim-speeddating'
"Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'reedes/vim-wordy'
"Plug 'terryma/vim-smooth-scroll'
"Plug 'mileszs/ack.vim'
"Plug 'vimwiki/vimwiki'

" colorschemes
Plug 'chriskempson/base16-vim'
Plug 'justinmk/vim-sneak'
"Plug 'KabbAmine/yowish.vim'
"Plug 'flazz/vim-colorschemes'
"Plug '0ax1/lxvc'
"Plug 'whatyouhide/vim-gotham'
"Plug 'FuDesign2008/randomColor.vim'

" etc
"Plug 'xolox/vim-lua-inspect'
"Plug 'rhysd/nyaovim-markdown-preview'
"Plug 'rhysd/nyaovim-mini-browser'
call plug#end()

" }}}

" plugin config {{{

" language client settings
set hidden
let g:LanguageClient_serverCommands = {
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ }
let g:LanguageClient_diagnosticsDisplay = {
            \     1: {
            \         "name": "Error",
            \         "texthl": "ALEError",
            \         "signText": "x",
            \         "signTexthl": "ALEErrorSign",
            \     },
            \     2: {
            \         "name": "Warning",
            \         "texthl": "ALEWarning",
            \         "signText": "!",
            \         "signTexthl": "ALEWarningSign",
            \     },
            \     3: {
            \         "name": "Information",
            \         "texthl": "ALEInfo",
            \         "signText": "i",
            \         "signTexthl": "ALEInfoSign",
            \     },
            \     4: {
            \         "name": "Hint",
            \         "texthl": "ALEInfo",
            \         "signText": ">",
            \         "signTexthl": "ALEInfoSign",
            \     },
            \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<cr>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<cr>

"" ack.vim setup: use rg instead
"if executable('rg')
"    let g:ackprg = 'rg --vimgrep'
"endif

" lightline settigns {{{
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
            \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'LightLineFugitive',
            \   'filename': 'LightLineFilename',
            \   'fileformat': 'LightLineFileformat',
            \   'filetype': 'LightLineFiletype',
            \   'fileencoding': 'LightLineFileencoding',
            \   'mode': 'LightLineMode',
            \   'ctrlpmark': 'CtrlPMark',
            \ },
            \ 'component_expand': {
            \   'syntastic': 'SyntasticStatuslineFlag',
            \ },
            \ 'component_type': {
            \   'syntastic': 'error',
            \ },
            \ 'subseparator': { 'left': '|', 'right': '|' }
            \ }

function! LightLineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
                \ fname == '__Tagbar__' ? g:lightline.fname :
                \ fname =~ '__Gundo\|NERD_tree' ? '' :
                \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
                \ &ft == 'unite' ? unite#get_status_string() :
                \ &ft == 'vimshell' ? vimshell#get_status_string() :
                \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ''  " edit here for cool mark
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endfunction

function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ fname == '__Gundo__' ? 'Gundo' :
                \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ &ft == 'unite' ? 'Unite' :
                \ &ft == 'vimfiler' ? 'VimFiler' :
                \ &ft == 'vimshell' ? 'VimShell' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

"augroup AutoSyntastic
"    autocmd!
"    autocmd BufWritePost *.c,*.cpp call s:syntastic()
"augroup END
"function! s:syntastic()
"    SyntasticCheck
"    call lightline#update()
"endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

"}}}

colo base16-gruvbox-dark-soft

filetype plugin on

" }}}

