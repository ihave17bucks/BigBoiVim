-- ╔══════════════════════════════════════════════════════╗
-- ║              BigBoiVim — ui/noice.lua               ║
-- ╚══════════════════════════════════════════════════════╝

return {
  -- nvim-notify: styled notification toasts (noice uses this as backend)
  {
    "rcarriga/nvim-notify",
    lazy = true,
    keys = {
      {
        "<leader>un",
        function() require("notify").dismiss({ silent = true, pending = true }) end,
        desc = "Dismiss notifications",
      },
    },
    opts = {
      stages    = "fade_in_slide_out",
      timeout   = 3000,
      max_width = 60,
      render    = "wrapped-compact",
      level     = vim.log.levels.INFO,
      icons = {
        ERROR = " ",
        WARN  = " ",
        INFO  = " ",
        DEBUG = " ",
        TRACE = "✎ ",
      },
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify   -- replace built-in vim.notify globally
    end,
  },

  -- noice: completely replaces cmdline, messages, and popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    keys = {
      { "<leader>sn",  "",                                                          desc = "+noice" },
      { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect cmdline output" },
      { "<leader>snl", function() require("noice").cmd("last") end,                desc = "Noice last message" },
      { "<leader>snh", function() require("noice").cmd("history") end,             desc = "Noice message history" },
      { "<leader>sna", function() require("noice").cmd("all") end,                 desc = "Noice all messages" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end,             desc = "Noice dismiss all" },
      -- Scroll through LSP hover / signature docs from normal mode
      { "<c-f>",       function() if not require("noice.lsp").scroll(4)  then return "<c-f>" end end, silent = true, expr = true, mode = { "i", "n", "s" }, desc = "Scroll forward (doc)" },
      { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, mode = { "i", "n", "s" }, desc = "Scroll back (doc)" },
    },
    opts = {
      lsp = {
        override = {
          -- Use noice's improved markdown renderer for LSP popups
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"]                = true,
          ["cmp.entry.get_documentation"]                  = true,
        },
        hover      = { enabled = true },
        signature  = { enabled = true },
        progress   = { enabled = true, throttle = 1000 / 30 },
      },
      routes = {
        -- Suppress noisy messages
        { filter = { event = "msg_show", any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "fewer lines" },
            { find = "written" },
        }}, opts = { skip = true } },
      },
      presets = {
        bottom_search         = true,   -- search bar at the bottom
        command_palette       = true,   -- floating cmdline + popupmenu
        long_message_to_split = true,   -- long messages go to split instead of popup
        inc_rename            = false,  -- disabled (inc-rename plugin handles this)
        lsp_doc_border        = true,   -- border on LSP hover docs
      },
    },
  },
}
