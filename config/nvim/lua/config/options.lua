-- Options
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8

-- Clipboard
opt.clipboard = "unnamedplus"

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Splits
opt.splitright = true
opt.splitbelow = true
