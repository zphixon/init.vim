
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
inoremap Jk <Esc>
inoremap JK <Esc>

inoremap unrwap unwrap
inoremap unrwpa unwrap
inoremap unwrpa unwrap

nnoremap j gj
nnoremap k gk

tmap jk <C-\><C-n>
tmap <Esc> <C-\><C-n>

let mapleader=" "
let maplocalleader="'"
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :so %<cr>

nnoremap <leader>fs :up<cr>
nnoremap <leader>sf :up<cr>
nnoremap <leader>ch :noh<cr>
nnoremap <leader>bd :BD<cr>

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
set linebreak
set nospell
set noshowmode
set noequalalways
set inccommand=nosplit
set tgc
set mouse=n
syntax on
"let &t_ut=''

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
Plug 'neovim/nvim-lspconfig'
"Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
"Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'

" highlighting
Plug 'sheerun/vim-polyglot'
Plug 'chrisbra/Colorizer'
"Plug 'dunedain289/vim-tup'
Plug 'mlochbaum/BQN', {'rtp': 'editors/vim'}
call s:local_plug('stones/vim')

" enhancements
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'qpkorr/vim-bufkill'
"Plug 'norcalli/typeracer.nvim'
Plug 'andrejlevkovitch/vim-lua-format'
Plug 'tpope/vim-abolish'
"Plug 'vimwiki/vimwiki'

" ui
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
"Plug 'itchyny/lightline.vim'
"Plug 'josa42/nvim-lightline-lsp'

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
"let g:vimwiki_list = [{'path': '~/source/wiki'}]

autocmd FileType lua nnoremap <buffer> <c-k> :call LuaFormat()<cr>
autocmd BufWrite *.lua :call LuaFormat()

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

" vsnip

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" nvim-lsp {{{
set completeopt=menuone,noinsert,noselect
set shortmess+=c

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        lua vim.lsp.buf.hover()
    endif
endfunction

nnoremap gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap K     <cmd>call <SID>show_documentation()<CR>
nnoremap <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap ]g    <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
nnoremap [g    <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <leader>rn <cmd> lua vim.lsp.buf.rename()<cr>

lua <<EOF

local cmp = require('cmp')
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})



local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['pylsp'].setup({capabilities = capabilities})
require('lspconfig')['rust_analyzer'].setup({capabilities = capabilities})
require('lspconfig')['zls'].setup({capabilities = capabilities})
require('lspconfig')['sumneko_lua'].setup({
    cmd = { 'lua-language-server' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                library = {
                    "${3rd}/love2d/library"
                },
                checkThirdParty = false,
            },
        },
    },
    capabilities = capabilities,
})

require('lspconfig')['clangd'].setup({ capabilities = capabilities })
EOF

" }}}

autocmd BufWritePost * GitGutter

" telescope
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>lr <cmd>lua require('telescope.builtin').lsp_references()<cr>

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
    %s/( /(/ge
    %s/ )/)/ge
    %s/\s*$//e
    'e
endf
" }}}

