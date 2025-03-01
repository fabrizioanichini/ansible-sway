return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		vim.o.foldcolumn = "1" -- Show fold markers
		vim.o.foldlevel = 99 -- Start with everything unfolded
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		require("ufo").setup({
			provider_selector = function(_, _, _)
				return { "lsp", "indent" } -- Use LSP and indentation for folds
			end,
		})

		-- Keybindings for folding
		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
		vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except some" })
		vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds more" })
	end,
}
