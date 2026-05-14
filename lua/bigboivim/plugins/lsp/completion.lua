-- BigBoiVim -- lsp/completion.lua

return {
  {
    "saghen/blink.cmp",
    event        = { "InsertEnter", "CmdlineEnter" },
    version      = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "moyiz/blink-emoji.nvim",
      "Kaiser-Yang/blink-cmp-git",
    },
    opts = {
      keymap = {
        preset      = "enter",
        ["<Tab>"]   = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-b>"]   = { "scroll_documentation_up", "fallback" },
        ["<C-f>"]   = { "scroll_documentation_down", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"]   = { "hide" },
        ["<CR>"]    = { "accept", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant       = "mono",
      },

      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show          = true,
          auto_show_delay_ms = 100,
          treesitter_highlighting = true,
          window = { border = "rounded" },
        },
        list = {
          selection = {
            preselect   = true,
            auto_insert = true,
          },
        },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind",           gap = 1 },
              { "source_name" },
            },
          },
        },
        ghost_text = { enabled = true },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji", "git" },
        providers = {
          lsp = {
            name         = "LSP",
            module       = "blink.cmp.sources.lsp",
            score_offset = 90,
          },
          path = {
            name         = "Path",
            module       = "blink.cmp.sources.path",
            score_offset = 25,
            opts = { trailing_slash = false, label_trailing_slash = true },
          },
          snippets = {
            name         = "Snippets",
            module       = "blink.cmp.sources.snippets",
            score_offset = 80,
            opts = {
              friendly_snippets  = true,
              search_paths       = { vim.fn.stdpath("config") .. "/snippets" },
              global_snippets    = { "all" },
              ignored_filetypes  = {},
            },
          },
          buffer = {
            name         = "Buffer",
            module       = "blink.cmp.sources.buffer",
            score_offset = 15,
            opts = {
              -- complete from all normal buffers, not just current
              get_bufnrs = function()
                return vim.tbl_filter(function(b)
                  return vim.bo[b].buftype == ""
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
          emoji = {
            name         = "Emoji",
            module       = "blink-emoji",
            score_offset = 10,
            opts = { insert = true },
          },
          git = {
            name         = "Git",
            module       = "blink-cmp-git",
            score_offset = 5,
          },
        },
      },

      -- Fix: cmdline sources moved out of sources{} into its own top-level key
      cmdline = {
        sources = { "cmdline" },
      },

      snippets = { preset = "luasnip" },

      signature = {
        enabled = true,
        window  = { border = "rounded" },
      },

      -- Fix: use_frecency and use_proximity replaced with nested table keys
      fuzzy = {
        frecency = { enabled = true },
        sorts    = { "score", "sort_text" },
      },
    },

    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    build        = "make install_jsregexp",
    lazy         = true,
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },

  { "rafamadriz/friendly-snippets", lazy = true },
}
