return {
	"goolord/alpha-nvim",
	event = "VimEnter", -- or lazy-load on 'VeryLazy' if you prefer
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- 1. ASCII Banner (Header)
		dashboard.section.header.val = {
			[[                                 ]],
			[[  _   _                 _        ]],
			[[ | \ | | ___  _ __ ___ | |__     ]],
			[[ |  \| |/ _ \| '_ ` _ \| '_ \    ]],
			[[ | |\  | (_) | | | | | | |_) |   ]],
			[[ |_| \_|\___/|_| |_| |_|_.__/    ]],
			[[                                 ]],
			[[      " Welcome to Neovim "      ]],
			[[                                 ]],
		}

		-- 2. Menu Buttons
		--    Each entry is { "icon", "description", <command to run> }
		--    If you want more/fewer buttons, just adjust the entries
		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
			dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("g", "  Live grep", ":Telescope live_grep <CR>"),
			dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		-- 3. Footer (Optional)
		dashboard.section.footer.val = {
			"Thank you for using Neovim!",
		}

		-- You can set highlights, so the ASCII art or the footer stands out.
		-- For example:
		-- vim.cmd([[ highlight DashboardHeader guifg=#569CD6 ]])
		-- vim.cmd([[ highlight DashboardCenter guifg=#DCDCAA ]])
		-- vim.cmd([[ highlight DashboardFooter guifg=#C586C0 ]])

		-- 4. Layout
		-- Adjust the layout if needed. By default, the dashboard has sections
		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		-- Final step: activate the configured layout
		alpha.setup(dashboard.config)
	end,
}
