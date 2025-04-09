return {
	"ibhagwan/fzf-lua",
	config = function()
		local fzf = require("fzf-lua")

		local fd_opts =
			"--type f --hidden --no-ignore --exclude .git --exclude venv --exclude .venv --exclude staticfiles --exclude node_modules --exclude __pycache__"
		local rg_opts =
			"--hidden --no-ignore --glob '!.git/*' --glob '!node_modules/*' --glob '!venv/*' --glob '!.venv/*' --glob '!staticfiles/*' --glob '!__pycache__/*'"

		fzf.setup({
			files = {
				fd_opts = fd_opts,
			},
			grep = {
				rg_opts = rg_opts,
			},
			winopts = {
				preview = {
					layout = "vertical",
					vertical = "up:50%",
					title = "Preview",
					scrollbar = "border",
				},
			},
			fzf_opts = {
				["--with-nth"] = "1..",
				["--preview-window"] = "wrap",
				["--preview"] = "bat --style=numbers --color=always --line-range=:100 {}",
			},
		})

		-- Search help tags
		vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "Search Help" })

		-- Search keymaps
		vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "Search Keymaps" })

		-- Search files including hidden files (respects .gitignore)
		vim.keymap.set("n", "<leader>sf", function()
			fzf.files({
				cwd = vim.loop.cwd(),
				fd_opts = fd_opts,
				previewer = "builtin",
			})
		end, { desc = "Search Files (including hidden, respecting .gitignore)" })

		-- List available built-in commands
		vim.keymap.set("n", "<leader>ss", fzf.builtin, { desc = "Search Builtin Commands" })

		-- Search for the word under cursor (or any word you type)
		vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "Search Word" })

		-- Live grep in the project excluding .venv (respects .gitignore)
		vim.keymap.set("n", "<leader>sg", function()
			fzf.live_grep({
				rg_opts = rg_opts,
				previewer = "builtin",
			})
		end, { desc = "Live Grep (excluding .venv, staticfiles, __pycache__, etc.)" })

		-- Resume previous search session
		vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "Resume Search" })

		-- Search recent files
		vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = "Search Recent Files" })

		-- List open buffers
		vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "Search Buffers" })

		-- Fuzzy search within the current buffer
		vim.keymap.set("n", "<leader>/", function()
			fzf.blines({
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
	end,
}
