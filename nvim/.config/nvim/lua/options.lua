vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd.colorscheme('catppuccin-mocha')
vim.g.have_nerd_font = true

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.showmode = false
opt.breakindent = true
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10
opt.confirm = true

-- Sync clipboard between OS and Neovim.
vim.schedule(function() opt.clipboard = 'unnamedplus' end)
