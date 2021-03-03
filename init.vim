
"_vimrc - Zack Hixon, cheezgi at github
"last updated 2016-03-24

" maps {{{
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
nnoremap <leader>sv :so %<cr>

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
if has('win32')
    set noswapfile
endif

filetype plugin on

if has('win32')
    let g:python3_host_prog='C:/Users/Zack/AppData/Local/Programs/Python/Python37/python.exe'
endif

" turn off bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

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

if has('nvim-0.5.0')
    Plug 'neovim/nvim-lsp'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
else
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" highlighting
Plug 'sheerun/vim-polyglot'

" enhancements
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'qpkorr/vim-bufkill'
Plug 'norcalli/typeracer.nvim'

" ui
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"call s:local_plug('just-a-status-line')
Plug 'zphixon/just-a-status-line'

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

" this is shit
function LspStatus() abort
    if luaeval('vim.tbl_isempty(vim.lsp.buf_get_clients())')
        return ''
    else
        lua LSP_NAME = ""; for k,v in pairs(vim.lsp.buf_get_clients()) do
                    \ LSP_NAME = v.name
                    \ end
        if luaeval('vim.lsp.buf.server_ready()')
            return luaeval('LSP_NAME')
        else
            return luaeval('"loading " .. LSP_NAME .. "..."')
        endif
    endif
endfunction

set hidden

if has('nvim-0.5.0')
    " nvim-lsp {{{
    set completeopt=menuone,noinsert,noselect
    set shortmess+=c

    lua
                \ function my_on_attach()
                \     require("completion").on_attach()
                \ end
                \ require("lspconfig").rust_analyzer.setup({
                \     on_attach = my_on_attach
                \ })

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            lua vim.lsp.buf.hover()
        endif
    endfunction

    "nnoremap gd    <cmd>lua vim.lsp.buf.declaration()<CR>
    "nnoremap <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap gd    <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap K     <cmd>call <SID>show_documentation()<CR>
    nnoremap gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap ]g    <cmd>NextDiagnostic<CR>
    nnoremap [g    <cmd>PrevDiagnostic<CR>

    let g:completion_sorting = 'none'
    autocmd FileType rust let g:completion_trigger_characters=['.', '::']
    " }}}
else
    " coc.nvim {{{
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

    autocmd CursorHold * silent call CocActionAsync('highlight')
    " }}}
endif

" jasl {{{
fu MyHighlight() abort
    if exists('*gruvbox_material#get_configuration')
        let g:gc = gruvbox_material#get_configuration()
        let g:gp = gruvbox_material#get_palette(g:gc.background, g:gc.palette)
        exe 'hi JaslNormal   guifg=' . g:gp.blue[0]   . ' guibg=#3a3735'
        exe 'hi JaslVisual   guifg=' . g:gp.green[0]  . ' guibg=#3a3735'
        exe 'hi JaslInsert   guifg=' . g:gp.purple[0] . ' guibg=#3a3735'
        exe 'hi JaslReplace  guifg=' . g:gp.red[0]    . ' guibg=#3a3735'
        exe 'hi JaslCommand  guifg=' . g:gp.yellow[0] . ' guibg=#3a3735'
        exe 'hi JaslTerminal guifg=' . g:gp.aqua[0]   . ' guibg=#3a3735'
        hi link JaslNormalOpPending        JaslNormal
        hi link JaslNormalOpPendingChar    JaslNormal
        hi link JaslNormalOpPendingLine    JaslNormal
        hi link JaslNormalOpPendingBlock   JaslNormal
        hi link JaslNormalCtrlO            JaslNormal
        hi link JaslNormalReplaceCtrlO     JaslNormal
        hi link JaslNormalVirtualCtrlO     JaslNormal
        hi link JaslVisualLine             JaslVisual
        hi link JaslVisualBlock            JaslVisual
        hi link JaslVisualSelect           JaslVisual
        hi link JaslVisualSelectLine       JaslVisual
        hi link JaslVisualSelectBlock      JaslVisual
        hi link JaslInsertInsertCompletion JaslInsert
        hi link JaslInsertCtrlX            JaslInsert
        hi link JaslReplaceCompletion      JaslReplace
        hi link JaslReplaceVirtual         JaslReplace
        hi link JaslReplaceCtrlX           JaslReplace
        hi link JaslCommandEx              JaslCommand
        hi link JaslCommandExNormal        JaslCommand
    else
        lua require('jasl').default_highlight()
    endif
endf

let g:jasl_highlight = 'call MyHighlight()'
" TODO: put this in its own file
let g:jasl_active = "require('jasl').active_line({\n"
\ . "  right = {\n"
\ . "    function()\n"
\ . "      return vim.fn.col('.')\n"
\ . "    end,\n"
\ . "    function()\n"
\ . "      return vim.o.ff\n"
\ . "    end,\n"
\ . "    function()\n"
\ . "      if vim.tbl_isempty(vim.lsp.buf_get_clients()) then\n"
\ . "        return ''\n"
\ . "      else\n"
\ . "        local server_name = ''\n"
\ . "        -- sometimes the client list doesnt start at 1 :(\n"
\ . "        for k, v in pairs(vim.lsp.buf_get_clients()) do\n"
\ . "          server_name = v.name\n"
\ . "        end\n"
\ . "        if vim.lsp.buf.server_ready() then\n"
\ . "          return server_name\n"
\ . "        else\n"
\ . "          return 'loading ' .. server_name .. '...'\n"
\ . "        end\n"
\ . "      end\n"
\ . "    end,\n"
\ . "  }\n"
\ . "})\n"


" }}}

autocmd BufWritePost * GitGutter

" }}}

" use tabs in gdscript3 files {{{
augroup GodotScriptTabs
    au!
    au FileType gdscript3 setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
    au FileType gdscript3 setlocal nolist
augroup END
" }}}

" normal lua/html/whatever indenting {{{
augroup FuckingChrist
    au!
    au FileType lua setlocal ts=2 sw=2 sts=2 et
    au FileType html setlocal ts=2 sw=2 sts=2 et
augroup END
" }}}

" fix prof shaw's stupid fucking indents and parens {{{
fu! FixProfShawsStupidFuckingIndentsAndParens()
    ma e
    %s///
    %s/( /(/ge
    %s/ )/)/ge
    %s/\s*$//e
    'e
endf
" }}}

