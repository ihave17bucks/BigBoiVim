-- BigBoiVim -- git/octo.lua
-- GitHub PRs, issues, and reviews inside Neovim

return {
  {
    "pwntester/octo.nvim",
    cmd          = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>go",  "<cmd>Octo<CR>",                          desc = "Octo" },
      { "<leader>goi", "<cmd>Octo issue list<CR>",               desc = "List issues" },
      { "<leader>gop", "<cmd>Octo pr list<CR>",                  desc = "List PRs" },
      { "<leader>gor", "<cmd>Octo review start<CR>",             desc = "Start review" },
      { "<leader>goa", "<cmd>Octo actions<CR>",                  desc = "Octo actions" },
    },
    opts = {
      use_local_fs           = false,
      enable_builtin         = true,
      default_remote         = { "upstream", "origin" },
      default_merge_method   = "commit",
      ssh_aliases            = {},
      picker                 = "telescope",
      picker_config = {
        use_emojis = true,
      },
      comment_icon           = "▎",
      outdated_icon          = "󰅒 ",
      resolved_icon          = " ",
      timeline_marker        = " ",
      timeline_indent        = "2",
      right_bubble_delimiter = "",
      left_bubble_delimiter  = "",
      github_hostname        = "",
      snippet_context_lines  = 4,
      gh_env                 = {},
      timeout                = 5000,
      ui = {
        use_signcolumn = true,
      },
      issues = {
        order_by = { field = "CREATED_AT", direction = "DESC" },
      },
      pull_requests = {
        order_by        = { field = "CREATED_AT", direction = "DESC" },
        always_select_remote_on_create = false,
      },
      file_panel = { size = 10, use_icons = true },
      colors = {
        white      = "#ffffff",
        grey       = "#2A354C",
        black      = "#000000",
        red        = "#f38ba8",
        dark_red   = "#f38ba8",
        green      = "#a6e3a1",
        dark_green = "#a6e3a1",
        yellow     = "#f9e2af",
        dark_yellow = "#fab387",
        blue       = "#89b4fa",
        dark_blue  = "#74c7ec",
        purple     = "#cba6f7",
      },
    },
  },
}
