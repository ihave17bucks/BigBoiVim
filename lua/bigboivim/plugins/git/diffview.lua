-- BigBoiVim -- git/diffview.lua

return {
  {
    "sindrets/diffview.nvim",
    cmd  = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd",  "<cmd>DiffviewOpen<CR>",                           desc = "Diff view (index)" },
      { "<leader>gD",  "<cmd>DiffviewOpen HEAD~1<CR>",                    desc = "Diff view (HEAD~1)" },
      { "<leader>gfh", "<cmd>DiffviewFileHistory %<CR>",                  desc = "File history (current)" },
      { "<leader>gfH", "<cmd>DiffviewFileHistory<CR>",                    desc = "File history (repo)" },
      { "<leader>gx",  "<cmd>DiffviewClose<CR>",                          desc = "Close diffview" },
    },
    opts = {
      diff_binaries     = false,
      enhanced_diff_hl  = true,
      git_cmd           = { "git" },
      hg_cmd            = { "hg" },
      use_icons         = true,
      show_help_hints   = true,
      watch_index       = true,
      icons = {
        folder_closed = "",
        folder_open   = "",
      },
      signs = {
        fold_closed = "",
        fold_open   = "",
        done        = "✓",
      },
      view = {
        default = {
          layout        = "diff2_horizontal",
          winbar_info   = false,
        },
        merge_tool = {
          layout        = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info   = true,
        },
        file_history = {
          layout        = "diff2_horizontal",
          winbar_info   = false,
        },
      },
      file_panel = {
        listing_style   = "tree",
        tree_options = {
          flatten_dirs             = true,
          folder_statuses          = "only_folded",
        },
        win_config = {
          position   = "left",
          width      = 35,
          win_opts   = {},
        },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position   = "bottom",
          height     = 16,
          win_opts   = {},
        },
      },
      commit_log_panel = {
        win_config = { win_opts = {} },
      },
      default_args = {
        DiffviewOpen        = {},
        DiffviewFileHistory = {},
      },
      hooks = {},
      keymaps = {
        disable_defaults = false,
        view = {
          { "n", "q",          "<cmd>DiffviewClose<CR>",                   { desc = "Close diffview" } },
          { "n", "<leader>gx", "<cmd>DiffviewClose<CR>",                   { desc = "Close diffview" } },
          { "n", "<tab>",      function() require("diffview").select_next_entry() end, { desc = "Next file" } },
          { "n", "<s-tab>",    function() require("diffview").select_prev_entry() end, { desc = "Prev file" } },
        },
        diff1 = { { "n", "?", "<cmd>h diffview-maps-diff1<CR>", { desc = "Help" } } },
        diff2 = { { "n", "?", "<cmd>h diffview-maps-diff2<CR>", { desc = "Help" } } },
        diff3 = { { "n", "?", "<cmd>h diffview-maps-diff3<CR>", { desc = "Help" } } },
        diff4 = { { "n", "?", "<cmd>h diffview-maps-diff4<CR>", { desc = "Help" } } },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
        },
      },
    },
  },
}
