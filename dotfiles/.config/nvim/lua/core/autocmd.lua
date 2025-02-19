-- ======================================================================
-- =                        core/autocmd.lua                            =
-- ======================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight text on yank
autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})