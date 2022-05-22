local current_dir = vim.fn.getcwd()
if vim.tbl_contains({'C:\\WINDOWS\\system32', 'C:\\Users\\Zack'}, current_dir) then
  vim.cmd('cd ~/source')
end

vim.cmd([[
 augroup Packer
   au!
   au BufWritePost init.lua PackerCompile
 augroup end
]])

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'

  -- highlighting
  use 'sheerun/vim-polyglot'
  use 'chrisbra/Colorizer'
  use {'mlochbaum/BQN', rtp = 'editors/vim'}

  -- enhancements
  use 'justinmk/vim-sneak'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'qpkorr/vim-bufkill'
  use 'andrejlevkovitch/vim-lua-format'
  use 'tpope/vim-abolish'

  -- ui
  use 'tpope/vim-fugitive'
  use 'tpope/vim-vinegar'
  use 'airblade/vim-gitgutter'
  use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}
  use 'lukas-reineke/indent-blankline.nvim'

  -- colorschemes
  use 'chriskempson/base16-vim'
  use 'AlessandroYorba/Alduin'
  use 'mbbill/desertEx'
  use 'sainnhe/sonokai'
  use 'sainnhe/edge'
  use 'sainnhe/gruvbox-material'
end)

local function command(cmd) return function() vim.cmd(cmd) end end

local function cursor_column()
  if vim.opt.cursorcolumn then
    vim.opt.cursorcolumn = false
  else
    vim.opt.cursorcolumn = true
  end
end

vim.keymap.set({'n', 'v'}, 'j', 'gj')
vim.keymap.set({'n', 'v'}, 'k', 'gk')
vim.keymap.set('n', '<M-p>', cursor_column)
vim.keymap.set('n', '<F5>', command('checktime'))
vim.keymap.set('t', 'jk', '<C-\\><C-n>')
vim.keymap.set('t', 'jk', '<C-\\><C-n>')
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'Jk', '<Esc>')
vim.keymap.set('i', 'JK', '<Esc>')
vim.keymap.set('i', 'unrwap', 'unwrap')
vim.keymap.set('i', 'unrwpa', 'unwrap')
vim.keymap.set('i', 'unwrpa', 'unwrap')

vim.api.nvim_set_var('mapleader', ' ')
vim.api.nvim_set_var('maplocalleader', "'")
vim.keymap.set('n', '<leader>ev', command('edit $MYVIMRC'))
vim.keymap.set('n', '<leader>sv', command('source $MYVIMRC'))
vim.keymap.set('n', '<leader>fs', command('update'))
vim.keymap.set('n', '<leader>sf', command('update'))
vim.keymap.set('n', '<leader>ch', command('nohlsearch'))
vim.keymap.set('n', '<leader>bd', command('BD'))

vim.keymap.set('n', '<leader>wh', '<C-w>h')
vim.keymap.set('n', '<leader>wj', '<C-w>j')
vim.keymap.set('n', '<leader>wk', '<C-w>k')
vim.keymap.set('n', '<leader>wl', '<C-w>l')
vim.keymap.set('n', '<leader>w/', command('vsplit'))
vim.keymap.set('n', '<leader>wd', command('quit'))
vim.keymap.set('n', '<leader>wn', command('split'))

vim.opt.swapfile = false

vim.cmd('filetype plugin on')

vim.opt.errorbells = false
vim.opt.visualbell = true
vim.cmd('autocmd GUIEnter * set visualbell t_vb=')

vim.opt.autoread = true
vim.opt.updatetime = 1000
vim.cmd('autocmd CursorHold, CursorHoldI * checktime')

vim.cmd('highlight ColorColumn guibg=LightMagenta')
vim.fn.matchadd('ColorColumn', '\\%81v', 100) -- string is sussy

vim.opt.scrolloff = 6
vim.opt.foldmethod = 'marker'

vim.opt.listchars = 'tab:»»,trail:█,nbsp:~'
vim.opt.list = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.spell = false
vim.opt.showmode = false
vim.opt.equalalways = false
vim.opt.inccommand = 'nosplit'
vim.opt.termguicolors = true
vim.opt.mouse = 'nv'
vim.cmd('syntax on')
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
vim.opt.shortmess:append({c = true})

vim.api.nvim_set_var('neovide_refresh_rate', 144)
vim.api.nvim_set_var('neovide_cursor_animation_length', 0.07)
vim.api.nvim_set_var('neovide_cursor_trail_length', 0.2)
vim.api.nvim_set_var('neovide_remember_window_size', true)
vim.api.nvim_set_var('neovide_input_use_logo', false)
vim.opt.guifont = {'Comic Mono:h10'}

-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- vim.opt.shiftwidth = 4
vim.opt.smarttab = true

vim.opt.formatoptions:remove('t')
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.tw = 0

vim.cmd('autocmd BufWritePost * GitGutter')

vim.keymap.set('n', '<leader>bb', command('Telescope buffers'))
vim.keymap.set('n', '<leader>ff', command('Telescope find_files'))
vim.keymap.set('n', '<leader>lr',
               function() require('telescope.builtin').lsp_references() end)

vim.opt.background = 'dark'
vim.api.nvim_set_var('gruvbox_material_background', 'medium')
vim.cmd('colorscheme gruvbox-material')

vim.cmd('autocmd FileType lua nnoremap <buffer> <c-k> :call LuaFormat()')
vim.cmd('autocmd BufWrite *.lua :call LuaFormat()')

vim.api.nvim_set_var('rustfmt_autosave', 1)

local function vsnip_jump(dir, plugbind, realbind)
  return function()
    if vim.fn['vsnip#jumpable'](dir) then
      return plugbind
    else
      return realbind
    end
  end
end

local function vsnip_forward()
  return vsnip_jump(1, '<Plug>(vsnip-jump-next)', '<Tab>')
end

local function vsnip_backward()
  return vsnip_jump(-1, '<Plug>(vsnip-jump-prev)', '<S-Tab>')
end

vim.keymap.set('i', '<Tab>', vsnip_forward(), {expr = true})
vim.keymap.set('s', '<Tab>', vsnip_forward(), {expr = true})
vim.keymap.set('i', '<S-Tab>', vsnip_backward(), {expr = true})
vim.keymap.set('s', '<S-Tab>', vsnip_backward(), {expr = true})

local function show_docs()
  local filetype = vim.opt.filetype:get()
  if vim.tbl_contains({'vim', 'help'}, filetype) then
    vim.cmd('help ' .. vim.fn.expand('<cword>'))
  else
    vim.lsp.buf.hover()
  end
end

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition)
vim.keymap.set('n', 'K', show_docs)
vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'g0', vim.lsp.buf.document_symbol)
vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol)
vim.keymap.set('n', ']g', vim.lsp.diagnostic.goto_next)
vim.keymap.set('n', '[g', vim.lsp.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

local cmp = require('cmp')
cmp.setup({
  snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
  }),
  sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'vsnip'}},
                               {{name = 'buffer'}}),
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                   .protocol
                                                                   .make_client_capabilities())

local sources = {'${3rd}/love2d/library'}
local nvim_runtime_sources = vim.api.nvim_get_runtime_file('', true)
for k, v in ipairs(nvim_runtime_sources) do sources[#sources + k] = v end

require('lspconfig')['pylsp'].setup({capabilities = capabilities})
require('lspconfig')['rust_analyzer'].setup({capabilities = capabilities})
require('lspconfig')['zls'].setup({capabilities = capabilities})
require('lspconfig')['sumneko_lua'].setup({
  cmd = {'lua-language-server'},
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT'},
      diagnostics = {globals = {'vim'}},
      workspace = {library = {"${3rd}/love2d/library"}, checkThirdParty = false},
      telemetry = {enable = false},
    },
  },
  capabilities = capabilities,
})

require('lspconfig')['clangd'].setup({capabilities = capabilities})
