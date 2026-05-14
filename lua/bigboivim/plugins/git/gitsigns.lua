-- BigBoiVim -- git/gitsigns.lua

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts  = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      signs_staged = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
      },
      signs_staged_enable    = true,
      signcolumn             = true,
      numhl                  = false,
      linehl                 = false,
      word_diff              = false,
      watch_gitdir           = { follow_files = true },
      auto_attach            = true,
      attach_to_untracked    = false,
      current_line_blame     = false, -- toggled via keymap
      current_line_blame_opts = {
        virt_text         = true,
        virt_text_pos     = "eol",
        delay             = 500,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "  <author>, <author_time:%R> · <summary>",
      preview_config = { border = "rounded" },

      on_attach = function(bufnr)
        local gs  = package.loaded.gitsigns
        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "Git: " .. desc })
        end

        -- Navigation between hunks
        map("n", "]h", function()
          if vim.wo.diff then vim.cmd.normal({ "]c", bang = true })
          else gs.nav_hunk("next") end
        end, "Next hunk")
        map("n", "[h", function()
          if vim.wo.diff then vim.cmd.normal({ "[c", bang = true })
          else gs.nav_hunk("prev") end
        end, "Prev hunk")
        map("n", "]H", function() gs.nav_hunk("last") end,  "Last hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First hunk")

        -- Hunk actions
        map({ "n", "v" }, "<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>",  "Stage hunk")
        map({ "n", "v" }, "<leader>ghr", "<cmd>Gitsigns reset_hunk<CR>",  "Reset hunk")
        map("n", "<leader>ghS", gs.stage_buffer,                           "Stage buffer")
        map("n", "<leader>ghR", gs.reset_buffer,                           "Reset buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk,                        "Undo stage hunk")
        map("n", "<leader>ghp", gs.preview_hunk,                           "Preview hunk")
        map("n", "<leader>ghP", gs.preview_hunk_inline,                    "Preview hunk inline")
        map("n", "<leader>ghd", gs.diffthis,                               "Diff this")
        map("n", "<leader>ghD", function() gs.diffthis("~") end,           "Diff this ~")

        -- Blame
        map("n", "<leader>gb",  gs.blame_line,                             "Blame line")
        map("n", "<leader>gB",  function() gs.blame_line({ full = true }) end, "Blame line (full)")
        map("n", "<leader>gtb", gs.toggle_current_line_blame,              "Toggle line blame")
        map("n", "<leader>gtd", gs.toggle_deleted,                         "Toggle deleted")
        map("n", "<leader>gtw", gs.toggle_word_diff,                       "Toggle word diff")
        map("n", "<leader>gtl", gs.toggle_linehl,                          "Toggle line highlight")

        -- Text objects: ih = inside hunk, ah = around hunk
        map({ "o", "x" }, "ih", "<cmd>Gitsigns select_hunk<CR>", "Select hunk")
        map({ "o", "x" }, "ah", "<cmd>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    },
  },
}
