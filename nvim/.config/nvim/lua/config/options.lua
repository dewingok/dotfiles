vim.cmd.colorscheme("catppuccin-mocha")
vim.g.have_nerd_font = true

local o = vim.opt
o.expandtab = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.number = true
o.relativenumber = true
o.mouse = "a"
o.scrolloff = 8
o.showmode = false
o.clipboard = "unnamedplus"
o.breakindent = true
o.undofile = true
o.signcolumn = "yes"
o.updatetime = 250
o.timeoutlen = 300
o.splitright = true
o.splitbelow = true
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.inccommand = "split"
