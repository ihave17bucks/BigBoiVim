-- ╔══════════════════════════════════════════════════════╗
-- ║              BigBoiVim — init.lua                   ║
-- ║         The Maximalist Neovim Distribution          ║
-- ╚══════════════════════════════════════════════════════╝

-- Leader must be set before lazy loads plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable built-in plugins we'll replace
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("bigboivim.core.options")
require("bigboivim.core.keymaps")
require("bigboivim.core.autocmds")
require("bigboivim.lazy")
