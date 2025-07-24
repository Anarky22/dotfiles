-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

-- Clipboard
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

-- Indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2

-- Use tab in makefiles
local maketab_group = vim.api.nvim_create_augroup("maketab", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	callback = function() vim.opt_local.expandtab = false end,
	group = maketab_group,
})

vim.opt.whichwrap = vim.opt.whichwrap + "<"
vim.opt.whichwrap = vim.opt.whichwrap + ">"
vim.opt.whichwrap = vim.opt.whichwrap + "h"
vim.opt.whichwrap = vim.opt.whichwrap + "l"

vim.opt.showmode = true

vim.opt.errorbells = false
vim.opt.timeoutlen = 500
vim.opt.visualbell = true

-- Save on focuslost
local focuslost_group = vim.api.nvim_create_augroup("focuslost", { clear = true })
vim.api.nvim_create_autocmd({"FocusLost"}, {
	pattern = "*",
	command = "wa",
	group = focuslost_group,
})

vim.opt.hidden = true
vim.opt.undofile = true
vim.opt.colorcolumn = "80"
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

-- relative numbers in normal mode, absolute in insert/no focus
vim.opt.number = true
vim.opt.relativenumber = true
local numbertoggle_group = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {
	pattern = '*',
	group=numbertoggle_group,
	callback = function() vim.opt.relativenumber = true end,
})
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
	pattern = '*',
	group=numbertoggle_group,
	callback = function() vim.opt.relativenumber = false end,
})

vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.scrolloff = 2

-- move by vertical lines
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })

vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

--leader mappings
-- turn off search highlight
vim.api.nvim_set_keymap("n", "<leader><space>", ":nohlsearch", {})
-- strip trailing whitespace
vim.api.nvim_set_keymap("n", "<leader>w", ":let _s=@/ <Bar> :%s/\\s\\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>", {})

-- folding
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 10
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Don't show matching
vim.opt.shortmess:append("c")
-- Diagnostics
vim.diagnostic.config({ virtual_text = true })
-- Unload default plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")
