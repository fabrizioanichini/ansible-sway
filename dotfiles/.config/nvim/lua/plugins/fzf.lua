return {
	"ibhagwan/fzf-lua",
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			-- You can add custom options here if needed
			-- For example, to change the preview layout, set winopts etc.
		})

		-- Keymaps similar to your Telescope setup

		-- Search help tags
		vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "Search Help" })

		-- Search keymaps
		vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "Search Keymaps" })

		-- Search files including hidden files (ignores .git directory)
		vim.keymap.set("n", "<leader>sf", function()
			fzf.files({
				cwd = vim.loop.cwd(),
				fd_opts = "--hidden --no-ignore-vcs --exclude .git",
			})
		end, { desc = "Search Files (including hidden)" })

		-- List available built-in commands (a general overview)
		vim.keymap.set("n", "<leader>ss", fzf.builtin, { desc = "Search Builtin Commands" })

		-- Search for the word under cursor (or any word you type)
		vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "Search Word" })

		-- Live grep in the project
		vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "Live Grep" })

		-- (Optional) Diagnostics search if you have a custom integration or want to leverage LSP diagnostics
		-- You might need to write a wrapper function if not directly supported.
		-- vim.keymap.set("n", "<leader>sd", fzf.lsp_document_diagnostics, { desc = "Search Diagnostics" })

		-- Resume previous search session
		vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "Resume Search" })

		-- Search recent files
		vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = "Search Recent Files" })

		-- List open buffers
		vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "Search Buffers" })

		-- Fuzzy search within the current buffer
		vim.keymap.set("n", "<leader>/", function()
			fzf.blines({
				-- Minimal preview for current buffer search
				winopts = { preview = { hidden = true } },
			})
		end, { desc = "Fuzzily search in current buffer" })

		-- Live grep in open files only
		vim.keymap.set("n", "<leader>s/", function()
			fzf.live_grep({
				open_files = true,
				prompt = "Live Grep in Open Files > ",
			})
		end, { desc = "Search in open files" })

		-- Search your Neovim configuration
		vim.keymap.set("n", "<leader>sn", function()
			fzf.files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Search Neovim Config" })
	end,
}
