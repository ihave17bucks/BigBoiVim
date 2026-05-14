-- BigBoiVim -- navigation/flash.lua

return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts  = {
      modes = {
        -- Enhanced f/t/F/T motions
        char = {
          enabled        = true,
          jump_labels    = false,  -- keep vanilla feel for f/t
          multi_line     = false,
          highlight      = { backdrop = false },
        },
        -- Flash search: jump to any search match with a label
        search = {
          enabled = true,
        },
        -- Treesitter-aware selection
        treesitter = {
          labels          = "abcdefghijklmnopqrstuvwxyz",
          jump            = { pos = "range", autojump = false },
          search          = { incremental = false },
          label           = { before = true, after = true, style = "inline" },
          highlight       = { backdrop = false, matches = false },
        },
      },
      label = {
        uppercase       = false,
        rainbow         = { enabled = true, shade = 5 },
        style           = "overlay",
      },
      highlight = {
        backdrop  = true,
        priority  = 5000,
      },
    },
    keys = {
      -- s: jump anywhere on screen with flash
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash jump" },
      -- S: treesitter-aware selection
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash treesitter" },
      -- r: remote flash (operate on distant text object)
      { "r",     mode = "o",               function() require("flash").remote() end,             desc = "Remote flash" },
      -- R: treesitter search from visual/operator mode
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter search" },
      -- Toggle flash in search mode
      { "<C-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle flash search" },
    },
  },
}
