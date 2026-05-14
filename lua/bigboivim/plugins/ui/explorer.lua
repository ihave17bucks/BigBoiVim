-- ╔══════════════════════════════════════════════════════╗
-- ║              BigBoiVim — ui/explorer.lua            ║
-- ╚══════════════════════════════════════════════════════╝

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd    = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e",  "<cmd>Neotree toggle<CR>",                        desc = "Toggle Explorer" },
      { "<leader>E",  "<cmd>Neotree focus<CR>",                         desc = "Focus Explorer" },
      { "<leader>fe", "<cmd>Neotree reveal<CR>",                        desc = "Reveal file in Explorer" },
      { "<leader>ge", "<cmd>Neotree float git_status<CR>",              desc = "Git status (neo-tree)" },
    },
    deactivate = function()
      vim.cmd("Neotree close")
    end,
    init = function()
      -- Open neo-tree if nvim was opened on a directory
      if vim.fn.argc(-1) == 1 then
        local stat = vim.uv.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
      filesystem = {
        bind_to_cwd      = false,
        follow_current_file  = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible         = false,
          hide_dotfiles   = false,  -- show dotfiles by default
          hide_gitignored = true,
          hide_by_name = { ".git", "node_modules", ".cache" },
        },
      },
      window = {
        position = "left",
        width    = 35,
        mappings = {
          ["<space>"] = "none",  -- don't conflict with leader
          ["Y"] = function(state)
            -- Copy file path to clipboard
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
            vim.notify("Copied: " .. path)
          end,
        },
      },
      default_component_configs = {
        indent = {
          with_expanders    = true,
          expander_collapsed = "",
          expander_expanded  = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            added     = "",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
        file_size = { enabled = true, required_width = 64 },
        type      = { enabled = true, required_width = 110 },
        last_modified = { enabled = true, required_width = 88 },
        created   = { enabled = true, required_width = 130 },
      },
    },
  },
}
