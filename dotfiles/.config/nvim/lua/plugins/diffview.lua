return {
	"sindrets/diffview.nvim",
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true,
			view = {
				default = {
					layout = "diff2_horizontal",
				},
			},
			keymaps = {
				view = {
					["q"] = "<Cmd>DiffviewClose<CR>",
					["<leader>co"] = "<Cmd>DiffviewOpen<CR>",
					["<leader>ch"] = "<Cmd>DiffviewFileHistory %<CR>",
				},
			},
		})

		-- More comprehensive keymaps
		vim.keymap.set("n", "<leader>dv", "<Cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
		vim.keymap.set("n", "<leader>dc", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" })
		vim.keymap.set("n", "<leader>dh", "<Cmd>DiffviewFileHistory %<CR>", { desc = "File History (current)" })
		vim.keymap.set("n", "<leader>dH", "<Cmd>DiffviewFileHistory<CR>", { desc = "File History (project)" })
		vim.keymap.set("n", "<leader>dr", "<Cmd>DiffviewRefresh<CR>", { desc = "Refresh Diffview" })
	end,
}
