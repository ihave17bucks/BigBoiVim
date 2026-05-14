-- BigBoiVim -- ui/statusline.lua

return {
  {
    "nvim-lualine/lualine.nvim",
    event        = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.opt.statusline = " BigBoiVim"
    end,
    opts = function()
      local icons = {
        diagnostics = {
          Error = " ",
          Warn  = " ",
          Hint  = " ",
          Info  = " ",
        },
        git = {
          added    = " ",
          modified = " ",
          removed  = " ",
        },
      }

      local function macro_recording()
        local reg = vim.fn.reg_recording()
        if reg == "" then return "" end
        return "  @" .. reg
      end

      local function short_path()
        local path = vim.fn.expand("%:~:.")
        if path == "" then return "[No Name]" end
        return path
      end

      local function lsp_clients()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then return "" end
        local names = {}
        for _, c in ipairs(clients) do
          table.insert(names, c.name)
        end
        return " " .. table.concat(names, ", ")
      end

      -- Fix: pass bufnr explicitly so gitsigns source is valid
      local function gitsigns_diff_source()
        local gs = package.loaded.gitsigns
        if not gs then return end
        local summary = vim.b.gitsigns_status_dict
        if not summary then return end
        return {
          added    = summary.added,
          modified = summary.changed,
          removed  = summary.removed,
        }
      end

      return {
        options = {
          theme                = "catppuccin",
          globalstatus         = true,
          disabled_filetypes   = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = { left = "", right = "" },
          section_separators   = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode" } },
          lualine_b = {
            { "branch" },
            {
              "diff",
              symbols = icons.git,
              source  = gitsigns_diff_source,
            },
          },
          lualine_c = {
            { short_path },
            { lsp_clients, color = { fg = "#a6e3a1" } },
          },
          lualine_x = {
            { macro_recording, color = { fg = "#f38ba8", gui = "bold" } },
            { "diagnostics",   symbols = icons.diagnostics },
            { "encoding" },
            { "fileformat",    symbols = { unix = "LF", dos = "CRLF", mac = "CR" } },
            { "filetype" },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "neo-tree", "lazy", "trouble", "quickfix" },
      }
    end,
  },
}
