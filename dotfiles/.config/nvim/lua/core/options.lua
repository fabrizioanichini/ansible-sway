-- ======================================================================
-- =                         core/options.lua                           =
-- ======================================================================

local opt = vim.opt

-- Use system clipboard
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)

-- Basic UI settings
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 10
opt.swapfile = false
