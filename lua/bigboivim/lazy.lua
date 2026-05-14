-- BigBoiVim -- lazy.lua

-- ╚══════════════════════════════════════════════════════╝

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Plugins are imported from individual spec files under lua/bigboivim/plugins/
  spec = {
    { import = "bigboivim.plugins" },
  },

  defaults = {
    lazy = true,       -- lazy-load everything by default
    version = false,   -- always use latest git, not semver tags
  },

  install = {
    colorscheme = { "catppuccin", "habamax" }, -- fallback if catppuccin not ready
  },

  checker = {
    enabled = true,    -- notify when plugin updates are available
    notify  = false,   -- don't spam on startup, just badge the Lazy icon
    frequency = 3600,  -- check once per hour
  },

  change_detection = {
    enabled = true,
    notify  = false,   -- silent config reload detection
  },

  ui = {
    border = "rounded",
    title  = "  BigBoiVim: Plugin Manager",
    icons  = {
      cmd        = " ",
      config     = "",
      event      = "󱐋",
      ft         = " ",
      init       = " ",
      import     = " ",
      keys       = " ",
      lazy       = "󰒲 ",
      loaded     = "●",
      not_loaded = "○",
      plugin     = " ",
      runtime    = " ",
      require    = "󰢱 ",
      source     = " ",
      start      = " ",
      task       = "✔ ",
      list       = { "●", "➜", "★", "‒" },
    },
  },

  performance = {
    cache = { enabled = true },
    rtp = {
      -- Disable built-in plugins that BigBoiVim replaces
      disabled_plugins = {
        "gzip", "matchit", "matchparen",
        "netrwPlugin", "tarPlugin", "tohtml",
        "tutor", "zipPlugin",
      },
    },
  },
})
