-- ======================================================================
-- =                         core/lazy.lua                              =
-- ======================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Core
	"tpope/vim-sleuth",

	-- Greeter
	require("plugins.greeter"),

	-- Git signs
	require("plugins.gitsigns"),

	-- VimFugitive
	require("plugins.fugitive"),

	-- WhichKey
	require("plugins.whichkey"),

	-- Telescope
	require("plugins.fzf"),

	-- LSP / Completion
	require("plugins.lsp"),
	require("plugins.cmp"),

	-- Autoformat
	require("plugins.conform"),

	-- Colorscheme
	require("plugins.colorscheme"),

	-- TODO Comments
	require("plugins.todo-comments"),

	-- mini.nvim modules
	require("plugins.mini"),

	-- Harpoon
	require("plugins.harpoon"),

	-- Treesitter
	require("plugins.treesitter"),

	-- Neo Tree
	require("plugins.neo-tree"),

	-- UFO
	require("plugins.ufo"),

	-- UFO
	require("plugins.diffview"),
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
