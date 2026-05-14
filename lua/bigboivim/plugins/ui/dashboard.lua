-- BigBoiVim -- ui/dashboard.lua

return {
  {
    "nvimdev/dashboard-nvim",
    event        = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local logo = [[
▀█████████▄   ▄█     ▄██████▄  ▀█████████▄   ▄██████▄   ▄█   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄
  ███    ███ ███    ███    ███   ███    ███ ███    ███ ███  ███    ███ ███  ▄██▀▀▀███▀▀▀██▄
  ███    ███ ███▌   ███    █▀    ███    ███ ███    ███ ███▌ ███    ███ ███▌ ███   ███   ███
 ▄███▄▄▄██▀  ███▌  ▄███         ▄███▄▄▄██▀  ███    ███ ███▌ ███    ███ ███▌ ███   ███   ███
▀▀███▀▀▀██▄  ███▌ ▀▀███ ████▄  ▀▀███▀▀▀██▄  ███    ███ ███▌ ███    ███ ███▌ ███   ███   ███
  ███    ██▄ ███    ███    ███   ███    ██▄ ███    ███ ███  ███    ███ ███  ███   ███   ███
  ███    ███ ███    ███    ███   ███    ███ ███    ███ ███  ███    ███ ███  ███   ███   ███
▄█████████▀  █▀     ████████▀  ▄█████████▀   ▀██████▀  █▀    ▀██████▀  █▀    ▀█   ███   █▀
      ]]

      local function safe_telescope(method)
        return function()
          local ok, builtin = pcall(require, "telescope.builtin")
          if ok then builtin[method]()
          else vim.notify("Telescope not loaded yet", vim.log.levels.WARN) end
        end
      end

      return {
        theme  = "hyper",
        config = {
          header = vim.split("\n" .. logo .. "\n", "\n"),
          week_header = { enable = false },

          shortcut = {
            {
              icon     = "  ",   -- codicon: search
              icon_hl  = "@function",
              desc     = "Find File",
              desc_hl  = "String",
              group    = "@function",
              action   = safe_telescope("find_files"),
              key      = "f",
              key_hl   = "Number",
            },
            {
              icon     = "  ",   -- codicon: new file
              icon_hl  = "DiagnosticHint",
              desc     = "New File",
              desc_hl  = "String",
              group    = "DiagnosticHint",
              action   = function() vim.cmd("enew") end,
              key      = "n",
              key_hl   = "Number",
            },
            {
              icon     = "  ",   -- codicon: history
              icon_hl  = "DiagnosticWarn",
              desc     = "Recent Files",
              desc_hl  = "String",
              group    = "DiagnosticWarn",
              action   = safe_telescope("oldfiles"),
              key      = "r",
              key_hl   = "Number",
            },
            {
              icon     = "  ",   -- codicon: search fuzzy
              icon_hl  = "DiagnosticInfo",
              desc     = "Live Grep",
              desc_hl  = "String",
              group    = "DiagnosticInfo",
              action   = safe_telescope("live_grep"),
              key      = "g",
              key_hl   = "Number",
            },
            {
              icon     = "  ",   -- devicon: git
              icon_hl  = "DiagnosticOk",
              desc     = "Git",
              desc_hl  = "String",
              group    = "DiagnosticOk",
              action   = function()
                local ok, _ = pcall(require, "neogit")
                if ok then vim.cmd("Neogit")
                else vim.notify("Neogit not loaded yet", vim.log.levels.WARN) end
              end,
              key      = "G",
              key_hl   = "Number",
            },
            {
              icon     = "  ",   -- devicon: neovim
              icon_hl  = "@string",
              desc     = "Config",
              desc_hl  = "String",
              group    = "@string",
              action   = function()
                vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua")
              end,
              key      = "c",
              key_hl   = "Number",
            },
            {
              icon     = "  ",   -- codicon: package
              icon_hl  = "@variable",
              desc     = "Lazy",
              desc_hl  = "String",
              group    = "@variable",
              action   = function() vim.cmd("Lazy") end,
              key      = "l",
              key_hl   = "Number",
            },
            {
              icon     = "  ",   -- codicon: tools
              icon_hl  = "DiagnosticWarn",
              desc     = "Mason",
              desc_hl  = "String",
              group    = "DiagnosticWarn",
              action   = function() vim.cmd("Mason") end,
              key      = "m",
              key_hl   = "Number",
            },
            {
              icon     = "  ",   -- codicon: close
              icon_hl  = "DiagnosticError",
              desc     = "Quit",
              desc_hl  = "String",
              group    = "DiagnosticError",
              action   = function() vim.cmd("qa") end,
              key      = "q",
              key_hl   = "Number",
            },
          },

          packages = { enable = true },

          project = {
            enable   = true,
            limit    = 6,
            icon     = " ",   -- codicon: repo
            icon_hl  = "@function",
            label    = " Recent Projects",
            action   = "Telescope find_files cwd=",
          },

          mru = {
            limit    = 8,
            icon     = " ",   -- codicon: history
            icon_hl  = "Title",
            label    = " Recent Files",
            cwd_only = false,
          },

          footer = function()
            local stats = require("lazy").stats()
            local ms    = math.floor(stats.startuptime * 100 + 0.5) / 100
            local v     = vim.version()
            local ver   = string.format("v%d.%d.%d", v.major, v.minor, v.patch)
            return {
              "",
              "  NVIM " .. ver
                .. "    " .. stats.loaded .. "/" .. stats.count .. " plugins"
                .. "    " .. ms .. "ms",
              "",
              "  BigBoiVim if in doubt, ship it.",
            }
          end,
        },
      }
    end,
  },
}
