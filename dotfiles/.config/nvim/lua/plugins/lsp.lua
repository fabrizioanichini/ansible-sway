-- ======================================================================
-- =                       plugins/lsp.lua                              =
-- ======================================================================
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} }, -- LSP status updates
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Diagnostic configuration ...
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

		-- nvim-cmp capabilities ...
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Example of custom server settings
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		}

		-- Make sure relevant tools/servers are installed
		local ensure_installed = vim.tbl_keys(servers)
		vim.list_extend(ensure_installed, { "stylua" })
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

		-- Attach Keymaps when LSP attaches
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
				end

				local fzf = require("fzf-lua")
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
				-- If you want code actions via fzf-lua:
				-- map('<leader>ca', function() fzf.lsp_code_actions() end, 'LSP: Code Action', { 'n', 'x' })
				-- Otherwise you can leave the built-in if you prefer:
				map("<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action", { "n", "x" })

				map("gD", vim.lsp.buf.declaration, "LSP: Goto Declaration")

				-- Optional highlight / inlay hints code...
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
					-- Clear references when LSP detaches
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(detach_ev)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = highlight_grp, buffer = detach_ev.buf })
						end,
					})
				end

				-- Toggle inlay hints if your language server supports them
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
