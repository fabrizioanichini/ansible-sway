-- ======================================================================
-- =                   plugins/colorscheme.lua                           =
-- ======================================================================
return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			styles = {
				comments = { italic = false },
			},
		})
		vim.cmd.colorscheme("gruvbox")
	end,
}
