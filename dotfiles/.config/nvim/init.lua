-- ======================================================================
-- =                       init.lua (entry point)                       =
-- ======================================================================

-- Set leader keys early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Indicate if you have a Nerd Font for any plugin configs that rely on icons
vim.g.have_nerd_font = true

-- Load core configurations
require("core.options")
require("core.keymaps")
require("core.autocmd")

-- Set up plugin manager & load plugin specifications
require("core.lazy")
