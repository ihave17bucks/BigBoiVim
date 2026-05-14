-- BigBoiVim -- terminal/tasks.lua

return {
  {
    "stevearc/overseer.nvim",
    cmd  = { "OverseerRun", "OverseerToggle", "OverseerBuild", "OverseerInfo",
             "OverseerOpen", "OverseerClose", "OverseerQuickAction", "OverseerTaskAction" },
    keys = {
      { "<leader>to",  "<cmd>OverseerToggle<CR>",      desc = "Overseer: toggle" },
      { "<leader>tr",  "<cmd>OverseerRun<CR>",         desc = "Overseer: run task" },
      { "<leader>tR",  "<cmd>OverseerQuickAction<CR>", desc = "Overseer: quick action" },
      { "<leader>tb",  "<cmd>OverseerBuild<CR>",       desc = "Overseer: build" },
      { "<leader>ti",  "<cmd>OverseerInfo<CR>",        desc = "Overseer: info" },
    },
    opts = {
      strategy   = { "toggleterm", direction = "horizontal", open_on_start = true },
      templates  = { "builtin" },
      auto_scroll = true,
      close_on_exit = false,
      task_list = {
        default_detail = 1,
        direction      = "bottom",
        min_height     = 8,
        max_height     = 14,
        bindings = {
          ["<CR>"]  = "RunAction",
          ["o"]     = "Open",
          ["p"]     = "TogglePreview",
          ["q"]     = "Close",
        },
      },
      form       = { border = "rounded", zindex = 40 },
      confirm    = { border = "rounded", zindex = 40 },
      task_win   = { border = "rounded", padding = 2 },
      help_win   = { border = "rounded" },
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "rouge8/neotest-rust",
    },
    keys = {
      { "<leader>tn",  function() require("neotest").run.run() end,                                        desc = "Test: run nearest" },
      { "<leader>tN",  function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Test: run file" },
      { "<leader>tl",  function() require("neotest").run.run_last() end,                                   desc = "Test: run last" },
      { "<leader>ts",  function() require("neotest").run.stop() end,                                       desc = "Test: stop" },
      { "<leader>tO",  function() require("neotest").output_panel.toggle() end,                            desc = "Test: output panel" },
      { "<leader>tS",  function() require("neotest").summary.toggle() end,                                 desc = "Test: summary" },
      { "[n",          function() require("neotest").jump.prev({ status = "failed" }) end,                 desc = "Prev failed test" },
      { "]n",          function() require("neotest").jump.next({ status = "failed" }) end,                 desc = "Next failed test" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({ runner = "pytest" }),
          require("neotest-go")({ experimental = { test_table = true } }),
          require("neotest-jest")(),
          require("neotest-vitest"){},
          require("neotest-rust")({ args = { "--no-capture" } }),
        },
        discovery    = { enabled = true },
        running      = { concurrent = true },
        status       = { enabled = true, signs = true, virtual_text = false },
        output       = { enabled = true, open_on_run = false },
        output_panel = { enabled = true, open_on_run = "short" },
        icons = {
          failed        = " ",
          passed        = " ",
          running       = " ",
          skipped       = " ",
          unknown       = " ",
          running_animated = { "⠋","⠙","⠹","⠸","⠼","⠴","⠦","⠧","⠇","⠏" },
        },
      })
    end,
  },
}
