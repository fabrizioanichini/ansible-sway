-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	-- See `:help nvim-treesitter` for details
	opts = {
		-- Add languages you want treesitter to install
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
		},
		-- If you miss a language, Treesitter can auto-install it if you open a buffer with that filetype
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages rely on Vim's built-in regex-based highlighting for certain features (like Ruby’s indentation).
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = {
			enable = true,
			disable = { "ruby" }, -- Example of disabling indent for certain filetypes
		},
	},
}
