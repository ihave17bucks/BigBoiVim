-- BigBoiVim -- editor/editing.lua
-- Core editing enhancements: surround, autopairs, comments, split/join

return {
  -- Surround: add/change/delete surrounding brackets, quotes, tags
  {
    "kylechui/nvim-surround",
    version = "*",
    event   = { "BufReadPost", "BufNewFile" },
    opts    = {
      keymaps = {
        insert          = "<C-g>s",
        insert_line     = "<C-g>S",
        normal          = "ys",
        normal_cur      = "yss",
        normal_line     = "yS",
        normal_cur_line = "ySS",
        visual          = "S",
        visual_line     = "gS",
        delete          = "ds",
        change          = "cs",
        change_line     = "cS",
      },
    },
  },

  -- Autopairs: bracket/quote pairing with blink.cmp integration
  {
    "windwp/nvim-autopairs",
    event  = "InsertEnter",
    opts   = {
      check_ts                 = true,   -- use treesitter to check context
      ts_config                = {
        lua  = { "string" },             -- don't pair in lua strings
        javascript = { "template_string" },
      },
      disable_filetype         = { "TelescopePrompt", "spectre_panel" },
      disable_in_macro         = true,
      disable_in_visualblock   = false,
      disable_in_replace_mode  = true,
      ignored_next_char        = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright         = true,
      enable_afterquote        = true,
      enable_check_bracket_line = true,
      enable_bracket_in_quote  = true,
      enable_abbr              = false,
      break_undo               = true,
      map_cr                   = true,
      map_bs                   = true,
      map_c_h                  = false,
      map_c_w                  = false,
    },
  },

  -- Comments: gcc for line, gbc for block, gco/gcO/gcA for insert
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      padding   = true,
      sticky    = true,
      ignore    = nil,
      toggler   = { line = "gcc", block = "gbc" },
      opleader  = { line = "gc",  block = "gb"  },
      extra     = { above = "gcO", below = "gco", eol = "gcA" },
      mappings  = { basic = true, extra = true },
      pre_hook  = nil,
      post_hook = nil,
    },
  },

  -- Split/join: gS to split, gJ to join (treesitter-aware)
  {
    "Wansmer/treesj",
    keys = {
      { "gS", function() require("treesj").split() end, desc = "Split block" },
      { "gJ", function() require("treesj").join()  end, desc = "Join block"  },
      { "gM", function() require("treesj").toggle() end, desc = "Toggle split/join" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
      check_syntax_error  = true,
      max_join_length     = 120,
      cursor_behavior     = "hold",
      notify              = true,
      dot_repeat          = true,
    },
  },

  -- Better text objects: ai, ii, a(, i(, a", i", etc.
  {
    "echasnovski/mini.ai",
    version = false,
    event   = { "BufReadPost", "BufNewFile" },
    opts    = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          -- Treesitter function/class/arg (falls back to mini.ai builtins)
          o = ai.gen_spec.treesitter({
            a = { "@block.outer",    "@conditional.outer", "@loop.outer" },
            i = { "@block.inner",    "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer",    i = "@class.inner"    }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- HTML tags
          d = { "%f[%d]%d+" },                                                  -- digits
          g = function(type, _)                                                  -- whole buffer
            local from = { line = 1, col = 1 }
            local to   = { line = vim.fn.line("$"), col = math.max(vim.fn.getline("$"):len(), 1) }
            return { from = from, to = to, vis_mode = type == "V" and "V" or nil }
          end,
        },
      }
    end,
  },

  -- mini.move: move lines/selections with Alt+hjkl
  {
    "echasnovski/mini.move",
    version = false,
    event   = { "BufReadPost", "BufNewFile" },
    opts    = {
      mappings = {
        left       = "<A-h>",
        right      = "<A-l>",
        down       = "<A-j>",
        up         = "<A-k>",
        line_left  = "<A-h>",
        line_right = "<A-l>",
        line_down  = "<A-j>",
        line_up    = "<A-k>",
      },
      options = { reindent_linewise = true },
    },
  },

  -- mini.pairs fallback (disabled — using nvim-autopairs above)
  -- Keeping this comment so it's easy to swap if needed

  -- Highlight word under cursor (different from illuminate — just shows matches)
  {
    "echasnovski/mini.cursorword",
    version = false,
    event   = { "BufReadPost", "BufNewFile" },
    opts    = { delay = 100 },
  },
}
