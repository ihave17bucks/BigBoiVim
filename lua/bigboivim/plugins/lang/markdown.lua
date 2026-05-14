-- BigBoiVim -- lang/markdown.lua

return {
  -- Live preview in browser
  {
    "iamcco/markdown-preview.nvim",
    cmd   = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft    = { "markdown" },
    build = "cd app && yarn install",
    keys  = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Markdown preview" },
    },
    config = function()
      vim.g.mkdp_auto_close    = 1
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_echo_preview_url  = 1
      vim.g.mkdp_theme         = "dark"
    end,
  },

  -- Render markdown beautifully in the buffer itself (Neovim 0.10+)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft           = { "markdown", "norg", "rmd", "org" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      enabled        = true,
      render_modes   = { "n", "c" },
      anti_conceal   = { enabled = true },
      heading = {
        enabled  = true,
        sign     = true,
        icons    = { "  ", "  ", "  ", "  ", "  ", "  " },
      },
      code = {
        enabled   = true,
        sign      = true,
        style     = "full",
        position  = "left",
        border    = "thin",
        highlight = "RenderMarkdownCode",
      },
      bullet = {
        enabled = true,
        icons   = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        enabled   = true,
        unchecked = { icon = "󰄱 " },
        checked   = { icon = "󰱒 " },
      },
      dash    = { enabled = true },
      quote   = { enabled = true, repeat_linebreak = false },
      table   = { enabled = true, style = "full" },
    },
  },

  -- Better markdown editing: lists, tables, toc
  {
    "tadmccorkle/markdown.nvim",
    ft   = { "markdown" },
    opts = {
      mappings = {
        inline_surround_toggle        = "gs",
        inline_surround_toggle_line   = "gss",
        inline_surround_delete        = "ds",
        inline_surround_change        = "cs",
        link_add                      = "gl",
        link_follow                   = "gx",
        go_curr_heading               = "]c",
        go_parent_heading             = "]p",
        go_next_heading               = "]]",
        go_prev_heading               = "[[",
      },
      toc = {
        omit_injected_lang_trees = true,
        omit_heading_pattern     = nil,
      },
    },
  },
}
