return {
	"tpope/vim-fugitive",
	-- Fugitive doesn’t strictly require plenary, but if you want it available for other git-related plugins, you could add:
	-- dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		-- ============================================================================
		-- Fugitive Keymaps
		-- ============================================================================
		--
		-- Opens an interactive Git status window (like `git status`).
		vim.keymap.set("n", "<leader>gs", ":G<CR>", { desc = "Fugitive: Git status" })

		-- Side-by-side diff of the current file with its staged version.
		vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Fugitive: Git diff" })

		-- Opens a commit buffer. Type your commit message and then close the buffer.
		vim.keymap.set("n", "<leader>gc", ":Gcommit<CR>", { desc = "Fugitive: Git commit" })

		-- Run arbitrary Git commands (pull, push, etc.). Example:
		vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Fugitive: Git push" })
		vim.keymap.set("n", "<leader>gP", ":Git pull<CR>", { desc = "Fugitive: Git pull" })

		-- ============================================================================
		-- Additional Fugitive Commands (not mapped by default, but useful to remember):
		-- ============================================================================
		-- :Gblame       -> Interactive blame for the current file.
		-- :Glog         -> Show commit log for the current file.
		-- :Gread        -> Revert current buffer to HEAD (discard local changes).
		-- :Gwrite       -> Stage changes in the current buffer.
		--
		-- :Gdiffsplit HEAD~1  -> Compare with the previous commit.
		-- :G push / :G pull   -> Run push/pull quickly.
		--
		-- For more commands, see :help fugitive
		-- ============================================================================
	end,
}
