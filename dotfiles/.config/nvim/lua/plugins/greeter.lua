return {
	"goolord/alpha-nvim",
	event = "VimEnter", -- or lazy-load on 'VeryLazy' if you prefer
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local fzf = require("fzf-lua")

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
		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find file", function()
				fzf.files({
					fd_opts = "--hidden --no-ignore-vcs --exclude .git",
				})
			end),
			dashboard.button("r", "  Recent files", fzf.oldfiles),
			dashboard.button("g", "  Live grep", fzf.live_grep),
			dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		-- 3. Footer (Optional)
		dashboard.section.footer.val = {
			"Thank you for using Neovim!",
		}

		-- 4. Layout
		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		-- Activate the configured layout
		alpha.setup(dashboard.config)
	end,
}
