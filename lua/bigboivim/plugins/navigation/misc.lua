-- BigBoiVim -- navigation/misc.lua
-- project detection, session management, quickfix enhancements

return {
  -- Project root detection + project switching
  {
    "ahmedkhalf/project.nvim",
    lazy   = false,
    priority = 900,
    config = function()
      require("project_nvim").setup({
        manual_mode          = false,
        detection_methods    = { "lsp", "pattern" },
        patterns             = { ".git", "Cargo.toml", "package.json", "Makefile", "go.mod", ".project" },
        ignore_lsp           = { "null-ls" },
        exclude_dirs         = { "~/.cargo/*" },
        show_hidden          = false,
        silent_chdir         = true,
        scope_chdir          = "global",
        datapath             = vim.fn.stdpath("data"),
      })
      -- Telescope integration loaded via telescope extension
    end,
  },

  -- Session management: auto-save and restore sessions per directory
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts  = {
      dir     = vim.fn.stdpath("state") .. "/sessions/",
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
      pre_save = nil,
    },
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore session (cwd)" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
      { "<leader>qS", function() require("persistence").save() end,                desc = "Save session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't save session on exit" },
    },
  },

  -- Better quickfix window
  {
    "kevinhwang91/nvim-bqf",
    ft   = "qf",
    opts = {
      auto_enable    = true,
      auto_resize_height = true,
      preview = {
        win_height    = 12,
        win_vheight   = 12,
        delay_syntax  = 80,
        border        = "rounded",
        show_title    = false,
        should_preview_cb = function(bufnr, _)
          local ret    = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize  = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then ret = false end
          return ret
        end,
      },
      filter = {
        fzf = {
          action_for = {
            ["ctrl-s"] = "split",
            ["ctrl-t"] = "tab drop",
            ["ctrl-v"] = "vsplit",
            ["ctrl-q"] = { action = nil, flag = "r" },
          },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    },
  },

  -- todo-comments: highlight and navigate TODO/FIXME/HACK/NOTE
  {
    "folke/todo-comments.nvim",
    cmd          = { "TodoTrouble", "TodoTelescope" },
    event        = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Prev todo comment" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>",                            desc = "Find TODOs" },
      { "<leader>xT", "<cmd>TodoTrouble<CR>",                              desc = "Todo (Trouble)" },
    },
    opts = {
      signs      = true,
      sign_priority = 8,
      keywords   = {
        FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning", alt = { "XXX" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "CAUTION" } },
        PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint",    alt = { "INFO" } },
        TEST = { icon = " ", color = "test",    alt = { "TESTING", "PASSED", "FAILED" } },
      },
      highlight  = {
        multiline         = true,
        multiline_pattern = "^.",
        before            = "",
        keyword           = "wide",
        after             = "fg",
        pattern           = [[.*<(KEYWORDS)\s*:]],
        comments_only     = true,
      },
    },
  },

  -- which-key group for new prefixes introduced in stage 5
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>h",  group = "harpoon",  icon = { icon = "󱡅 ", color = "orange" } },
        { "<leader>q",  group = "sessions", icon = { icon = " ", color = "blue" } },
        { "<leader>x",  group = "trouble",  icon = { icon = " ", color = "red" } },
      },
    },
  },
}
