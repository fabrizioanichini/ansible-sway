return {
	-- Harpoon plugin on the "harpoon2" branch
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED for harpoon to work properly
		harpoon:setup({
			-- You can customize global settings or per-list settings here.
			-- For example:
			-- settings = {
			--   save_on_toggle = true,
			--   sync_on_ui_close = true,
			-- },
			-- default = {
			--   -- You can override default behavior (which is a file-based list).
			-- },
			-- [ "my_custom_list_name" ] = { ... },
		})

		-- ===== Example Keymaps =====
		--
		-- Adds the current file to Harpoon's "file list"
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon: Add file" })

		-- Toggles the Harpoon quick menu
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon: Toggle UI" })

		-- Jump to specific file mark
		vim.keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon: Go to file 1" })
		vim.keymap.set("n", "<C-t>", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon: Go to file 2" })
		vim.keymap.set("n", "<C-n>", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon: Go to file 3" })
		vim.keymap.set("n", "<C-s>", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon: Go to file 4" })

		-- Navigate to previous/next buffers in Harpoon's list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end, { desc = "Harpoon: Prev item" })
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end, { desc = "Harpoon: Next item" })

		-- ===== Telescope Integration (optional) =====
		--
		-- If you prefer using Telescope’s UI to pick Harpoon files, you can
		-- replace the above `<C-e>` mapping with something like below:
		--
		--   local conf = require("telescope.config").values
		--   local function toggle_telescope(harpoon_files)
		--     local file_paths = {}
		--     for _, item in ipairs(harpoon_files.items) do
		--       table.insert(file_paths, item.value)
		--     end
		--     require("telescope.pickers").new({}, {
		--       prompt_title = "Harpoon",
		--       finder = require("telescope.finders").new_table({
		--         results = file_paths,
		--       }),
		--       previewer = conf.file_previewer({}),
		--       sorter = conf.generic_sorter({}),
		--     }):find()
		--   end
		--
		--   vim.keymap.set("n", "<C-e>", function()
		--     toggle_telescope(harpoon:list())
		--   end, { desc = "Harpoon: Open via Telescope" })
		--
	end,
}
