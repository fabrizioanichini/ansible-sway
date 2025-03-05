--------------------------------------------------------------------------------
-- File: plugins/lsp.lua
--------------------------------------------------------------------------------
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Mason is used for installing language servers, linters, etc.
		{ "williamboman/mason.nvim", opts = {} },
		-- Mason-lspconfig automatically sets up nvim-lspconfig for installed servers.
		"williamboman/mason-lspconfig.nvim",
		-- Mason-tool-installer can ensure tools (like formatters & linters) are installed.
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- For LSP status updates in the Neovim UI
		{ "j-hui/fidget.nvim", opts = {} },
		-- For autocompletion capabilities
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		------------------------------------------------------------------------
		-- Diagnostic configuration: style, signs, virtual text, etc.
		------------------------------------------------------------------------
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

		------------------------------------------------------------------------
		-- CMP capabilities to let servers know we support completion
		------------------------------------------------------------------------
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		------------------------------------------------------------------------
		-- Define servers we want nvim-lspconfig to handle:
		--   - "lua_ls" for Lua
		--   - "tsserver" for TypeScript/JavaScript
		--   - "pyright" for Python
		------------------------------------------------------------------------
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
					},
				},
			},
			tsserver = {
				-- Additional tsserver config goes here if desired.
			},
			pyright = {
				-- Additional pyright config goes here if desired, for example:
				-- settings = {
				--   python = {
				--     analysis = {
				--       autoImportCompletions = true,
				--       diagnosticMode = "workspace",
				--       typeCheckingMode = "basic",
				--     },
				--   },
				-- },
			},
		}

		------------------------------------------------------------------------
		-- Setup Mason to install each tool/server we need by its correct name.
		-- Here, we also install formatters or linters (like "stylua") if wanted.
		------------------------------------------------------------------------
		local ensure_installed = {
			"stylua", -- for Lua formatting
			"lua-language-server", -- for lua_ls
			"typescript-language-server", -- for tsserver
			"pyright", -- for pyright
			-- add "prettier", "black", "eslint-lsp", or others here if you like
		}

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
		})

		------------------------------------------------------------------------
		-- Mason-lspconfig automatically sets up each server with nvim-lspconfig.
		------------------------------------------------------------------------
		require("mason-lspconfig").setup({
			-- If you want mason-lspconfig to auto-install these servers:
			-- ensure_installed = { "lua_ls", "tsserver", "pyright" },

			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		------------------------------------------------------------------------
		-- Attach keymaps and inlay hints whenever an LSP connects to a buffer
		------------------------------------------------------------------------
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				-- Helper for setting keymaps
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
				end

				local fzf = require("fzf-lua")
				-- LSP-based navigation with FZF
				map("gd", function()
					fzf.lsp_definitions()
				end, "LSP: Goto Definition")
				map("gr", function()
					fzf.lsp_references()
				end, "LSP: Goto References")
				map("gI", function()
					fzf.lsp_implementations()
				end, "LSP: Goto Implementation")
				map("<leader>D", function()
					fzf.lsp_typedefs()
				end, "LSP: Type Definitions")
				map("<leader>ds", function()
					fzf.lsp_document_symbols()
				end, "LSP: Document Symbols")
				map("<leader>ws", function()
					fzf.lsp_workspace_symbols()
				end, "LSP: Workspace Symbols")

				-- Code actions via built-in LSP
				map("<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action", { "n", "x" })

				-- Declaration
				map("gD", vim.lsp.buf.declaration, "LSP: Goto Declaration")

				----------------------------------------------------------------------
				-- Optional: Document highlight references if server supports it
				----------------------------------------------------------------------
				local function client_supports_method(client, method, bufnr)
					if vim.fn.has("nvim-0.11") == 1 then
						return client:supports_method(method, bufnr)
					else
						return client.supports_method(method, { bufnr = bufnr })
					end
				end

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client_supports_method(client, "textDocument/documentHighlight", event.buf) then
					local highlight_grp = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = highlight_grp,
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = highlight_grp,
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
					-- Clear references on detach
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(detach_ev)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = highlight_grp, buffer = detach_ev.buf })
						end,
					})
				end

				----------------------------------------------------------------------
				-- Optional: Toggle inlay hints if supported (requires Neovim 0.10+)
				----------------------------------------------------------------------
				if client and client_supports_method(client, "textDocument/inlayHint", event.buf) then
					map("<leader>th", function()
						local buf_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
						vim.lsp.inlay_hint(event.buf, not buf_enabled)
					end, "LSP: Toggle Inlay Hints")
				end
			end,
		})
	end,
}
