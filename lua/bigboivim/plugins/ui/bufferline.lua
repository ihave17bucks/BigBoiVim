-- BigBoiVim -- ui/bufferline.lua

return {
  {
    "akinsho/bufferline.nvim",
    event        = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin buffer" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close unpinned buffers" },
      { "<leader>br", "<cmd>BufferLineCloseRight<CR>",           desc = "Close buffers to the right" },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<CR>",            desc = "Close buffers to the left" },
      { "[b",         "<cmd>BufferLineCyclePrev<CR>",            desc = "Prev buffer" },
      { "]b",         "<cmd>BufferLineCycleNext<CR>",            desc = "Next buffer" },
    },
    opts = {
      options = {
        mode          = "buffers",
        themable      = true,
        numbers       = "none",
        close_command = "bdelete! %d",
        diagnostics   = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = { error = " ", warning = " ", hint = " ", info = " " }
          local result = {}
          for name, icon in pairs(icons) do
            if diag[name] and diag[name] > 0 then
              table.insert(result, icon .. diag[name])
            end
          end
          return #result > 0 and table.concat(result, " ") or ""
        end,
        offsets = {
          {
            filetype   = "neo-tree",
            text       = "  BigBoiVim",
            text_align = "left",
            separator  = true,
          },
        },
        show_buffer_close_icons = true,
        show_close_icon         = false,
        separator_style         = "slant",
        always_show_bufferline  = false,
        hover = {
          enabled = true,
          delay   = 200,
          reveal  = { "close" },
        },
      },
    },
  },
}
