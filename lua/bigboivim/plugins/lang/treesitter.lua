-- BigBoiVim -- lang/treesitter.lua
-- nvim-treesitter v1+ API: require("nvim-treesitter").setup()

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build        = ":TSUpdate",
    event        = { "BufReadPost", "BufNewFile", "VeryLazy" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    cmd  = { "TSUpdate", "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    main = "nvim-treesitter",
    opts = {
      ensure_installed = "all",
      auto_install     = true,
      sync_install     = false,

      highlight = {
        enable  = true,
        disable = function(_, buf)
          local max = 1024 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max then return true end
        end,
        additional_vim_regex_highlighting = false,
      },

      indent = { enable = true },

      incremental_selection = {
        enable  = true,
        keymaps = {
          init_selection    = "<C-space>",
          node_incremental  = "<C-space>",
          scope_incremental = "<C-S-space>",
          node_decremental  = "<bs>",
        },
      },

      textobjects = {
        select = {
          enable    = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer",    desc = "outer function" },
            ["if"] = { query = "@function.inner",    desc = "inner function" },
            ["ac"] = { query = "@class.outer",       desc = "outer class" },
            ["ic"] = { query = "@class.inner",       desc = "inner class" },
            ["ai"] = { query = "@conditional.outer", desc = "outer conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "inner conditional" },
            ["al"] = { query = "@loop.outer",        desc = "outer loop" },
            ["il"] = { query = "@loop.inner",        desc = "inner loop" },
            ["aa"] = { query = "@parameter.outer",   desc = "outer parameter" },
            ["ia"] = { query = "@parameter.inner",   desc = "inner parameter" },
            ["ab"] = { query = "@block.outer",       desc = "outer block" },
            ["ib"] = { query = "@block.inner",       desc = "inner block" },
            ["ak"] = { query = "@call.outer",        desc = "outer call" },
            ["ik"] = { query = "@call.inner",        desc = "inner call" },
          },
        },
        move = {
          enable    = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = { query = "@function.outer",    desc = "Next function start" },
            ["]c"] = { query = "@class.outer",       desc = "Next class start" },
            ["]a"] = { query = "@parameter.inner",   desc = "Next parameter" },
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional" },
            ["]l"] = { query = "@loop.outer",        desc = "Next loop" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer",    desc = "Next function end" },
            ["]C"] = { query = "@class.outer",       desc = "Next class end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@function.outer",    desc = "Prev function start" },
            ["[c"] = { query = "@class.outer",       desc = "Prev class start" },
            ["[a"] = { query = "@parameter.inner",   desc = "Prev parameter" },
            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional" },
            ["[l"] = { query = "@loop.outer",        desc = "Prev loop" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@function.outer",    desc = "Prev function end" },
            ["[C"] = { query = "@class.outer",       desc = "Prev class end" },
          },
        },
        swap = {
          enable    = true,
          swap_next     = { ["<leader>ca"] = { query = "@parameter.inner", desc = "Swap next parameter" } },
          swap_previous = { ["<leader>cA"] = { query = "@parameter.inner", desc = "Swap prev parameter" } },
        },
        lsp_interop = {
          enable  = true,
          border  = "rounded",
          peek_definition_code = {
            ["<leader>lp"] = { query = "@function.outer", desc = "Peek function definition" },
            ["<leader>lP"] = { query = "@class.outer",   desc = "Peek class definition" },
          },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
  },
}
