return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- Optional, for file icons
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = { ".DS_Store", "node_modules" },
				},
				follow_current_file = { enabled = true }, -- ✅ Fixed syntax for Neo-tree v3.x
				use_libuv_file_watcher = true,
			},
			window = {
				position = "right",
				width = 35,
				mappings = {
					-- 🔹 NetRW-Like Mappings
					["<CR>"] = "open", -- Enter opens file/directory
					["-"] = "navigate_up", -- Go up one directory (like `-` in NetRW)
					["a"] = { "add", config = { show_path = "relative" } }, -- Create file/directory
					["d"] = "delete", -- Delete file/directory
					["r"] = "rename", -- Rename file/directory
					["y"] = "copy", -- Yank file/directory (copy)
					["x"] = "cut_to_clipboard", -- Cut (like `d` in NetRW)
					["p"] = "paste_from_clipboard", -- Paste (like `p` in NetRW)
					["q"] = "close_window", -- Close Neo-tree (like `q` in NetRW)
					["R"] = "refresh", -- Refresh the file tree
				},
			},
		})

		-- ✅ Global mapping for <leader>e to toggle Neo-tree (like NetRW `:Explore`)
		vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
	end,
}
