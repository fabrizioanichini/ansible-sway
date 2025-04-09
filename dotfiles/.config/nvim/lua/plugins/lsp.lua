--------------------------------------------------------------------------------
-- File: plugins/lsp.lua
--------------------------------------------------------------------------------
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					return diagnostic.message
				end,
			},
		})

		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
			tsserver = {},
			pyright = {
				settings = {
					python = {
						analysis = {
							autoImportCompletions = true,
							typeCheckingMode = "basic",
							diagnosticMode = "workspace",
						},
					},
				},
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
				end,
			},
		}

		local ensure_installed = {
			"stylua",
			"lua-language-server",
			"typescript-language-server",
			"pyright",
		}

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
		})

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		-- Native indentation on save for Python files
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("auto_indent_on_save", { clear = true }),
			pattern = "*.py",
			callback = function()
				local pos = vim.api.nvim_win_get_cursor(0)
				vim.cmd("silent normal! gg=G")
				vim.api.nvim_win_set_cursor(0, pos)
			end,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
				end

				local fzf = require("fzf-lua")
				map("gd", fzf.lsp_definitions, "LSP: Goto Definition")
				map("gr", fzf.lsp_references, "LSP: Goto References")
				map("gI", fzf.lsp_implementations, "LSP: Goto Implementation")
				map("<leader>D", fzf.lsp_typedefs, "LSP: Type Definitions")
				map("<leader>ds", fzf.lsp_document_symbols, "LSP: Document Symbols")
				map("<leader>ws", fzf.lsp_workspace_symbols, "LSP: Workspace Symbols")

				map("<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "LSP: Goto Declaration")
			end,
		})
	end,
}
