-- BigBoiVim -- editor/ui.lua
-- Editor-level UI: undotree, zen mode, search enhancements, scrollbar

return {
  -- Visual undo tree
  {
    "mbbill/undotree",
    cmd  = "UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" },
    },
    config = function()
      vim.g.undotree_WindowLayout       = 2
      vim.g.undotree_SplitWidth         = 35
      vim.g.undotree_DiffpanelHeight    = 12
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_TreeNodeShape      = ""
      vim.g.undotree_TreeVertShape      = "│"
      vim.g.undotree_TreeSplitShape     = "╱"
      vim.g.undotree_TreeReturnShape    = "╲"
      vim.g.undotree_ShortIndicators    = 0
      vim.g.undotree_RelativeTimestamp  = 1
      vim.g.undotree_HighlightChangedText = 1
    end,
  },

  -- Zen mode: distraction-free writing
  {
    "folke/zen-mode.nvim",
    cmd  = "ZenMode",
    keys = {
      { "<leader>uz", "<cmd>ZenMode<CR>", desc = "Toggle zen mode" },
    },
    opts = {
      window = {
        backdrop  = 0.92,
        width     = 120,
        height    = 1,
        options   = {
          signcolumn    = "no",
          number        = false,
          relativenumber = false,
          cursorline    = false,
          cursorcolumn  = false,
          foldcolumn    = "0",
          list          = false,
        },
      },
      plugins = {
        options  = { enabled = true, ruler = false, showcmd = false, laststatus = 0 },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux     = { enabled = false },
        todo     = { enabled = false },
      },
    },
  },

  -- Twilight: dim inactive code portions in zen mode + standalone
  {
    "folke/twilight.nvim",
    cmd  = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
      { "<leader>uT", "<cmd>Twilight<CR>", desc = "Toggle twilight" },
    },
    opts = {
      dimming = {
        alpha    = 0.25,
        color    = { "Normal", "#ffffff" },
        term_bg  = "#000000",
        inactive = false,
      },
      context  = 10,
      treesitter = true,
      expand   = { "function", "method", "table", "if_statement" },
      exclude  = {},
    },
  },

  -- Better search UI: shows match count, clears highlight automatically
  {
    "kevinhwang91/nvim-hlslens",
    event = "BufReadPost",
    keys  = {
      { "n",  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Next match" },
      { "N",  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Prev match" },
      { "*",  [[*<Cmd>lua require('hlslens').start()<CR>]],  desc = "Search word forward" },
      { "#",  [[#<Cmd>lua require('hlslens').start()<CR>]],  desc = "Search word backward" },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search WORD forward" },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search WORD backward" },
    },
    opts  = {
      calm_down        = true,
      nearest_only     = false,
      nearest_float_when = "always",
      float_shadow_blend = 50,
      virt_priority    = 100,
      build_position_cb = function(plist, _, _, _)
        require("scrollbar.handlers.search").handler.show(plist.start_pos)
      end,
    },
  },

  -- Scrollbar with git + search integration
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      show              = true,
      show_in_active_only = false,
      set_highlights    = true,
      folds             = 1000,
      max_lines         = false,
      hide_if_all_visible = true,
      throttle_ms       = 100,
      handle = {
        text       = " ",
        blend      = 30,
        color      = nil,
        color_nr   = nil,
        highlight  = "CursorColumn",
        hide_if_all_visible = true,
      },
      marks = {
        Cursor    = { text = "─", priority = 0, gui = nil, color = nil, highlight = "Normal" },
        Search    = { text = { "─", "═" }, priority = 1, highlight = "Search" },
        Error     = { text = { "─", "═" }, priority = 2, highlight = "DiagnosticVirtualTextError" },
        Warn      = { text = { "─", "═" }, priority = 3, highlight = "DiagnosticVirtualTextWarn" },
        Info      = { text = { "─", "═" }, priority = 4, highlight = "DiagnosticVirtualTextInfo" },
        Hint      = { text = { "─", "═" }, priority = 5, highlight = "DiagnosticVirtualTextHint" },
        Misc      = { text = { "─", "═" }, priority = 6, highlight = "Normal" },
        GitAdd    = { text = "│", priority = 7, highlight = "GitSignsAdd" },
        GitChange = { text = "│", priority = 7, highlight = "GitSignsChange" },
        GitDelete = { text = "▼", priority = 7, highlight = "GitSignsDelete" },
      },
      excluded_buftypes  = { "terminal" },
      excluded_filetypes = { "cmp_docs", "cmp_menu", "noice", "prompt", "TelescopePrompt" },
      autocmd = { render = { "BufWinEnter", "TabEnter", "TermEnter", "WinEnter", "CmdwinLeave",
                             "TextChanged", "VimResized", "WinScrolled" },
                  clear = { "BufWinLeave", "TabLeave", "TermLeave", "WinLeave" } },
      handlers = {
        cursor    = true,
        diagnostic = true,
        gitsigns  = true,   -- requires gitsigns.nvim
        handle    = true,
        search    = true,   -- requires hlslens
        ale       = false,
      },
    },
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPost",
    opts  = {
      mappings          = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor       = true,
      stop_eof          = true,
      respect_scrolloff = true,
      cursor_scrolls_alone = true,
      easing            = "sine",
      pre_hook          = nil,
      post_hook         = nil,
      performance_mode  = false,
    },
  },
}
