-- BigBoiVim -- telescope/init.lua

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd          = "Telescope",
    version      = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-frecency.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      { "debugloop/telescope-undo.nvim" },
      { "jvgrootveld/telescope-zoxide" },
    },
    keys = {
      -- Files
      { "<leader>ff", function() require("telescope.builtin").find_files() end,                         desc = "Find files" },
      { "<leader>fr", function() require("telescope").extensions.frecency.frecency() end,               desc = "Recent files (frecency)" },
      { "<leader>fb", function() require("telescope.builtin").buffers({ sort_mru = true }) end,         desc = "Buffers" },
      { "<leader>fe", function() require("telescope").extensions.file_browser.file_browser() end,       desc = "File browser" },
      { "<leader>fp", function() require("telescope").extensions.project.project({}) end,               desc = "Projects" },
      { "<leader>fz", function() require("telescope").extensions.zoxide.list() end,                     desc = "Zoxide dirs" },

      -- Search
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,                          desc = "Live grep" },
      { "<leader>fw", function() require("telescope.builtin").grep_string({ word_match = "-w" }) end,   desc = "Grep word under cursor" },
      { "<leader>fG", function() require("telescope.builtin").live_grep({ cwd = false }) end,           desc = "Live grep (cwd)" },
      { "<leader>/",  function() require("telescope.builtin").current_buffer_fuzzy_find() end,          desc = "Fuzzy find in buffer" },

      -- Vim
      { "<leader>fk", function() require("telescope.builtin").keymaps() end,                            desc = "Keymaps" },
      { "<leader>fc", function() require("telescope.builtin").commands() end,                           desc = "Commands" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end,                          desc = "Help tags" },
      { "<leader>fm", function() require("telescope.builtin").marks() end,                              desc = "Marks" },
      { "<leader>fq", function() require("telescope.builtin").quickfix() end,                           desc = "Quickfix" },
      { "<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end,               desc = "Document symbols" },
      { "<leader>fS", function() require("telescope.builtin").lsp_workspace_symbols() end,              desc = "Workspace symbols" },
      { "<leader>fd", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,           desc = "Buffer diagnostics" },
      { "<leader>fD", function() require("telescope.builtin").diagnostics() end,                        desc = "Workspace diagnostics" },
      { "<leader>ft", function() require("telescope.builtin").treesitter() end,                         desc = "Treesitter symbols" },

      -- Git
      { "<leader>gf", function() require("telescope.builtin").git_files() end,                         desc = "Git files" },
      { "<leader>gc", function() require("telescope.builtin").git_commits() end,                        desc = "Git commits" },
      { "<leader>gs", function() require("telescope.builtin").git_status() end,                         desc = "Git status" },
      { "<leader>gS", function() require("telescope.builtin").git_stash() end,                          desc = "Git stash" },

      -- Undo tree
      { "<leader>fu", function() require("telescope").extensions.undo.undo() end,                      desc = "Undo history" },

      -- Resume last picker
      { "<leader>f.", function() require("telescope.builtin").resume() end,                             desc = "Resume last picker" },
    },
    opts = function()
      local actions    = require("telescope.actions")
      local themes     = require("telescope.themes")

      return {
        defaults = {
          prompt_prefix    = "   ",
          selection_caret  = " ",
          entry_prefix     = "  ",
          multi_icon       = " ",
          path_display     = { "truncate" },
          sorting_strategy = "ascending",
          layout_strategy  = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width   = 0.55,
              results_width   = 0.8,
            },
            vertical = { mirror = false },
            width        = 0.87,
            height       = 0.80,
            preview_cutoff = 120,
          },
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons  = true,
          set_env         = { COLORTERM = "truecolor" },
          vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "--trim",
          },
          mappings = {
            i = {
              ["<C-j>"]   = actions.move_selection_next,
              ["<C-k>"]   = actions.move_selection_previous,
              ["<C-n>"]   = actions.cycle_history_next,
              ["<C-p>"]   = actions.cycle_history_prev,
              ["<C-u>"]   = false,   -- clear prompt instead of scroll
              ["<C-d>"]   = actions.delete_buffer,
              ["<C-q>"]   = actions.send_to_qflist + actions.open_qflist,
              ["<C-s>"]   = actions.select_horizontal,
              ["<C-v>"]   = actions.select_vertical,
              ["<C-t>"]   = actions.select_tab,
              ["<Esc>"]   = actions.close,
              ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            },
            n = {
              ["q"]     = actions.close,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["dd"]    = actions.delete_buffer,
            },
          },
        },

        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", ".git" },
            hidden       = true,
          },
          buffers = {
            theme         = "dropdown",
            previewer     = false,
            initial_mode  = "normal",
            sort_lastused = true,
            mappings      = { n = { ["dd"] = actions.delete_buffer } },
          },
          live_grep = {
            additional_args = { "--hidden" },
          },
          help_tags = {
            theme = "ivy",
          },
          commands = {
            theme = "ivy",
          },
        },

        extensions = {
          fzf = {
            fuzzy                   = true,
            override_generic_sorter = true,
            override_file_sorter    = true,
            case_mode               = "smart_case",
          },
          file_browser = {
            theme         = "ivy",
            hijack_netrw  = true,
            hidden        = { file_browser = true, folder_browser = true },
            grouped       = true,
            previewer     = false,
            initial_mode  = "normal",
            layout_config = { height = 0.4 },
          },
          ["ui-select"] = {
            themes.get_dropdown({ previewer = false }),
          },
          frecency = {
            show_scores     = false,
            show_unindexed  = true,
            ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
          },
          undo = {
            use_delta          = true,
            side_by_side       = true,
            layout_strategy    = "vertical",
            layout_config      = { preview_height = 0.8 },
            mappings = {
              i = {
                ["<CR>"]    = require("telescope-undo.actions").yank_additions,
                ["<S-CR>"]  = require("telescope-undo.actions").yank_deletions,
                ["<C-CR>"]  = require("telescope-undo.actions").restore,
              },
              n = {
                ["y"]  = require("telescope-undo.actions").yank_additions,
                ["Y"]  = require("telescope-undo.actions").yank_deletions,
                ["u"]  = require("telescope-undo.actions").restore,
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      -- Load all extensions
      local extensions = {
        "fzf", "file_browser", "ui-select",
        "frecency", "project", "undo", "zoxide",
      }
      for _, ext in ipairs(extensions) do
        pcall(telescope.load_extension, ext)
      end
    end,
  },
}
