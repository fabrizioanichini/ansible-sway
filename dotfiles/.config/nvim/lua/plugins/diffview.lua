return {
	"sindrets/diffview.nvim",
	config = function()
		require("diffview").setup({
			-- Customize diffview options here if desired.
			enhanced_diff_hl = true, -- For better diff highlighting
		})
		-- Map a key for opening the diff view.
		vim.keymap.set("n", "<leader>dv", require("diffview").open, { desc = "Open Diffview" })
	end,
}
