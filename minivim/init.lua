require "deps".setup()

-------------------------
-- Miscellanous
-------------------------

local o = vim.opt
-- Basic
o.undofile = true
o.undolevels = 10000
o.undodir = vim.fn.expand("~/.vim/undodir")

o.syntax = "on"
o.number = true
o.relativenumber = true
o.scrolloff = 11
o.winborder = "single"
vim.cmd("filetype plugin on")
vim.cmd("set list")
vim.cmd("set lcs=space.")

-- Indent
o.breakindent = true
o.autoindent = true
o.expandtab = true
o.smarttab = true
o.linebreak = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4


-- Search
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = false
o.wildmode = "longest:full, full"
o.wildmenu = true
vim.cmd("set completeopt+=noselect")

-- Miscellanous
o.termguicolors = true
o.cursorline = true
o.conceallevel = 0
o.ruler = true
o.wrap = false
o.signcolumn = "yes"
o.showmode = true
o.lazyredraw = false
o.cmdheight = 1
o.showmatch = true
o.splitright = true
vim.o.background = "dark"

-- File Things
o.swapfile = false
o.path:append("**")
o.modifiable = true
o.autoread = true
o.autowrite = false

-- Optimizations
o.updatetime = 200
o.timeoutlen = 500

-- Clipboard
vim.cmd("set clipboard+=unnamedplus")


-------------------------
-- Keymaps
-------------------------
vim.g.mapleader = " "

local km = function(mode, trigger, action, config)
  vim.keymap.set(mode, trigger, action, config)
end

km('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })  -- Save file
km('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })  -- Quit Neovim
km('n', '<leader>e', ':e .<CR>', { noremap = true, silent = true })  -- Open file explorer
km('n', '<leader>t', ':terminal <CR>', { noremap = false, silent = true })  -- Open file explorer
km('n', '<leader>bd', ':bdelete! <CR>', { noremap = true, silent = true})  -- Closes a buffer
km('n', '<leader>xt', vim.treesitter.start, { noremap = true, silent = true})
km({"i", "n"}, "<C-j>", "<", { noremap = true, silent = true })
km({"i", "n"}, "<C-k>", ">", { noremap = true, silent = true })
km("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-------------------------
-- Plugins
-------------------------

local add = MiniDeps.add
add({
  source = "neovim/lsp-config",
  depends = { "williamboman/mason.nvim"},
})
add({
  source = "nvim-treesitter/nvim-treesitter",
  checkout = "main",
  hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
})
require "nvim-treesitter.configs".setup({
  ensure_installed = { "lua", "vimdoc" },
  highlight = { enable = true },
})

add({
  source = "nvim-mini/mini.icons"
})
add({
  source = "nvim-mini/mini.completion"
})
add({
  source = "nvim-mini/mini.pairs"
})
add({
  source = "uff20xd/yugener",
})
add({
  source = "uff20xd/postvim.nvim",
})
require "postvim".setup({})
