-- BigBoiVim -- navigation/outline.lua

return {
  -- Symbol outline panel
  {
    "hedyhli/outline.nvim",
    cmd  = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>lo", "<cmd>Outline<CR>", desc = "Toggle symbol outline" },
    },
    opts = {
      outline_window = {
        position       = "right",
        width          = 30,
        relative_width = false,
        auto_close     = false,
        auto_jump      = false,
        jump_highlight_duration = 300,
        center_on_jump = true,
        show_numbers   = false,
        show_relative_numbers = false,
        wrap           = false,
        focus_on_open  = false,
        winhl          = "Normal:NormalFloat",
      },
      outline_items = {
        show_symbol_details  = true,
        show_symbol_lineno   = true,
        highlight_hovered_item = true,
        auto_set_cursor      = true,
      },
      guides = {
        enabled = true,
        markers = { bottom = "└", middle = "├", vertical = "│" },
      },
      symbol_folding = {
        autofold_depth     = 1,
        auto_unfold_hover  = true,
        markers            = { "▸", "▾" },
      },
      preview_window = {
        auto_preview       = false,
        open_hover_on_preview = false,
        width              = 50,
        min_width          = 50,
        relative_width     = true,
        border             = "rounded",
        winhl              = "NormalFloat:",
        winhl_cursorline   = "Visual",
      },
      keymaps = {
        show_help         = "?",
        close             = { "<Esc>", "q" },
        goto_location     = "<CR>",
        peek_location     = "o",
        goto_and_close    = "<S-CR>",
        restore_location  = "<C-g>",
        hover_symbol      = "K",
        toggle_preview    = "P",
        rename_symbol     = "r",
        code_actions      = "a",
        fold              = "h",
        unfold            = "l",
        fold_all          = "W",
        unfold_all        = "E",
        fold_reset        = "R",
        down_and_jump     = "<C-j>",
        up_and_jump       = "<C-k>",
      },
    },
  },

  -- Breadcrumbs: shows current symbol path in winbar
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      -- Attach navic whenever an LSP with documentSymbol support connects
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method("textDocument/documentSymbol") then
            require("nvim-navic").attach(client, event.buf)
          end
        end,
      })
    end,
    opts = {
      separator       = "  ",
      highlight       = true,
      depth_limit     = 5,
      icons = {
        File          = " ",
        Module        = " ",
        Namespace     = " ",
        Package       = " ",
        Class         = " ",
        Method        = " ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = " ",
        Interface     = " ",
        Function      = " ",
        Variable      = " ",
        Constant      = " ",
        String        = " ",
        Number        = " ",
        Boolean       = " ",
        Array         = " ",
        Object        = " ",
        Key           = " ",
        Null          = " ",
        EnumMember    = " ",
        Struct        = " ",
        Event         = " ",
        Operator      = " ",
        TypeParameter = " ",
      },
    },
  },

  -- Winbar using navic breadcrumbs
  {
    "utilyre/barbecue.nvim",
    event        = { "BufReadPost", "BufNewFile" },
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
    name         = "barbecue",
    opts = {
      attach_navic   = false,  -- we attach manually via LspAttach above
      show_dirname   = false,
      show_basename  = true,
      show_modified  = true,
      modified_indicator = " ",
      leading_custom_section = function()
        return { { " ", "WinBar" } }
      end,
      theme          = "catppuccin-mocha",
      kinds = {
        File          = " ",
        Module        = " ",
        Namespace     = " ",
        Package       = " ",
        Class         = " ",
        Method        = " ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = " ",
        Interface     = " ",
        Function      = " ",
        Variable      = " ",
        Constant      = " ",
        String        = " ",
        Number        = " ",
        Boolean       = " ",
        Array         = " ",
        Object        = " ",
        Key           = " ",
        Null          = " ",
        EnumMember    = " ",
        Struct        = " ",
        Event         = " ",
        Operator      = " ",
        TypeParameter = " ",
      },
    },
  },
}
