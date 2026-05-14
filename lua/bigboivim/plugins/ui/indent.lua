-- ╔══════════════════════════════════════════════════════╗
-- ║              BigBoiVim — ui/indent.lua              ║
-- ╚══════════════════════════════════════════════════════╝

return {
  -- Indent guides with scope highlighting
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main  = "ibl",
    opts  = {
      indent = {
        char      = "│",
        tab_char  = "│",
      },
      scope = {
        enabled         = true,
        show_start      = true,
        show_end        = false,
        highlight       = { "Function", "Label" },
        priority        = 500,
      },
      exclude = {
        filetypes = {
          "help", "alpha", "dashboard", "neo-tree",
          "Trouble", "trouble", "lazy", "mason",
          "notify", "toggleterm", "lazyterm",
        },
      },
    },
  },

  -- Show current code context (function/class) at the top of the window
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      enable            = true,
      max_lines         = 3,   -- max lines of context shown
      min_window_height = 20,
      line_numbers      = true,
      multiline_threshold = 20,
      trim_scope        = "outer",
      mode              = "cursor",
      separator         = nil,
      zindex            = 20,
    },
    keys = {
      {
        "[c",
        function() require("treesitter-context").go_to_context(vim.v.count1) end,
        desc = "Jump to context",
      },
    },
  },

  -- Inline hex/rgb/hsl colour previews
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      filetypes = { "*" },
      user_default_options = {
        RGB      = true,
        RRGGBB   = true,
        names    = false,   -- don't colour "Red", "Blue" etc. (too noisy)
        css      = true,
        css_fn   = true,
        mode     = "virtualtext",
        virtualtext = "■",
      },
    },
  },

  -- Highlight all references to the word under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      delay                 = 200,
      large_file_cutoff     = 2000,
      large_file_overrides  = { providers = { "lsp" } },
      filetypes_denylist    = { "neo-tree", "dashboard", "trouble", "lazy" },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      -- Navigate between references
      vim.keymap.set("n", "]]", function() require("illuminate").goto_next_reference(false) end, { desc = "Next reference" })
      vim.keymap.set("n", "[[", function() require("illuminate").goto_prev_reference(false) end, { desc = "Prev reference" })
    end,
  },

  -- Dims inactive splits
  {
    "levouh/tint.nvim",
    event = "WinNew",
    opts  = {
      tint         = -35,
      saturation   = 0.7,
      tint_background_colors = false,
      highlight_ignore_patterns = { "WinSeparator", "Status.*" },
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local ft    = vim.bo[bufid].filetype
        local ignore = { "neo-tree", "dashboard", "lazy", "toggleterm" }
        return vim.tbl_contains(ignore, ft)
      end,
    },
  },

  -- Icons (required by many plugins)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- UI component library (required by neo-tree, noice, etc.)
  { "MunifTanjim/nui.nvim",        lazy = true },
}
