-- ===================== Basic Vim Settings =====================
vim.cmd 'colorscheme evening'  -- Colorscheme

-- Interface settings
vim.o.number = true            -- Show absolute line numbers
vim.o.relativenumber = true    -- Show relative line numbers
vim.o.scrolloff = 8            -- Keep at least 8 lines visible above/below the cursor when scrolling
vim.o.clipboard = 'unnamedplus' -- Use system clipboard

-- ===================== Key Mappings =====================
vim.g.mapleader = ' '  -- Set space as the leader key

vim.api.nvim_set_keymap('n', '<leader>sf', ':Files ./<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })

