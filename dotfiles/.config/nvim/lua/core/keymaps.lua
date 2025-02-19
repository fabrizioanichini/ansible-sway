-- ======================================================================
-- =                         core/keymaps.lua                           =
-- ======================================================================

-- Convenience function for defining keymaps
local keymap = vim.keymap.set

-- Clear highlights on <Esc> (normal mode)
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

-- Easier terminal escape
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move left" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move right" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move down" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move up" })
