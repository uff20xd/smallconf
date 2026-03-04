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
vim.cmd("colorscheme retrobox")

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


---------------------------------------------------------------------------
-- Netwr Config
---------------------------------------------------------------------------

local function Path()
  -- local path = vim.fn.expand('%:~:.') -- Relative
  local path = vim.fn.expand('%:~') -- Absolute
  return '%#StatusLine# ' .. path
end

WinBarNetRW = function()
  return table.concat {
    Path(),
    "%=",
    "%<",
  }
end

vim.api.nvim_create_augroup('netrw', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'netrw',
  pattern = 'netrw',
  callback = function()
    vim.api.nvim_command('setlocal buftype=nofile')
    vim.api.nvim_command('setlocal bufhidden=wipe')
    vim.opt_local.winbar = '%!v:lua.WinBarNetRW()'
    vim.keymap.set('n', 'e', '<CMD>Ex ~<CR>', { remap = true, silent = true, buffer = true })
    vim.keymap.set('n', 'w', '<CMD>Ex ' .. vim.fn.getcwd() .. '<CR>', { remap = true, silent = true, buffer = true })
    vim.keymap.set('n', 'h', '-', { remap = true, silent = true, buffer = true })
    vim.keymap.set('n', 'l', '<CR>', { remap = true, silent = true, buffer = true })
    vim.keymap.set('n', 'r', 'R', { remap = true, silent = true, buffer = true })
    vim.keymap.set('n', 'c', ':cd %<CR>', { remap = true, silent = true, buffer = true })
    local _none = {
      '<c-h>', 'a', 'C', 'gp', 'mf', 'mb', 'mB', 'mz', 'gb', 'qb', 'gn', 'mt', 'mT', 'md', 'me', 'cb', 'mr',
    }

    local unbinds = {
      '<F1>', '<del>', '<c-r>', '<c-tab>', 'gd', 'gf', 'I', 'mx',
      'mg', 'mh', 'mu', 'mv', 'mX', 'o', 'O', 'p', 'P',  'qf', 'qF',
      'qL', 'S', 't', 'u', 'U',  'X', 's',
    }
    for _, value in pairs(unbinds) do
      vim.keymap.set('n', value, '<CMD>lua print("Keybind \'' .. value .. '\' has been removed")<CR>', { noremap = true, silent = true, buffer = true })
    end
  end
})

vim.g.netrw_banner = 2
vim.g.netrw_liststyle = 1
-- vim.g.netrw_preview = 1
vim.g.netrw_bufsettings = 'nonu nornu noma ro nobl'
vim.g.netrw_browse_split = 0 -- (4 to open in other window)
vim.g.netrw_altfile = 0 -- (4 to open in other window)
vim.g.netrw_special_syntax = 3
vim.g.netrw_sort_by = 'exten'

