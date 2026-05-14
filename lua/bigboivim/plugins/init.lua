-- ╔══════════════════════════════════════════════════════╗
-- ║          BigBoiVim — plugins/init.lua               ║
-- ╚══════════════════════════════════════════════════════╝
--
-- Each stage adds an import entry here.
-- lazy.nvim merges all returned specs automatically.

return {
  -- ── Colorscheme (always first) ─────────────────────────────────────────────
  {
    "catppuccin/nvim",
    name     = "catppuccin",
    priority = 1000,
    lazy     = false,
    opts = {
      flavour = "mocha",
      background = { light = "latte", dark = "mocha" },
      transparent_background = false,
      term_colors = true,
      dim_inactive = { enabled = true, shade = "dark", percentage = 0.15 },
      integrations = {
        cmp              = true,
        gitsigns         = true,
        nvimtree         = false,
        neotree          = true,
        telescope        = { enabled = true },
        treesitter       = true,
        treesitter_context = true,
        lsp_trouble      = true,
        mason            = true,
        noice            = true,
        notify           = true,
        which_key        = true,
        illuminate       = true,
        indent_blankline = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors      = { "underline" },
            hints       = { "underline" },
            warnings    = { "underline" },
            information = { "underline" },
          },
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ── Stage 2: UI layer ──────────────────────────────────────────────────────
  { import = "bigboivim.plugins.ui" },

  -- ── Stage 3: LSP + Mason + completion ─────────────────────────────────────
  { import = "bigboivim.plugins.lsp" },

  -- ── Stage 4: Treesitter + language tooling ─────────────────────────────────
  { import = "bigboivim.plugins.lang" },

  -- ── Stage 5: Telescope + navigation ────────────────────────────────────────
  { import = "bigboivim.plugins.telescope" },
  { import = "bigboivim.plugins.navigation" },

  -- ── Stage 6: Git suite ─────────────────────────────────────────────────────
  { import = "bigboivim.plugins.git" },

  -- ── Stage 7: Editor QoL ────────────────────────────────────────────────────
  { import = "bigboivim.plugins.editor" },

  -- ── Stage 8: Terminal + Tasks + AI ────────────────────────────────────────
  { import = "bigboivim.plugins.terminal" },
  { import = "bigboivim.plugins.ai" },
  -- { import = "bigboivim.plugins.completion" },
  -- { import = "bigboivim.plugins.treesitter" },
  -- { import = "bigboivim.plugins.telescope" },
  -- { import = "bigboivim.plugins.git" },
  -- { import = "bigboivim.plugins.editor" },
  -- { import = "bigboivim.plugins.terminal" },
  -- { import = "bigboivim.plugins.ai" },
}
