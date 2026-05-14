-- BigBoiVim -- ui/whichkey.lua

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay  = 300,
      icons = {
        breadcrumb = "»",
        separator  = "➤",
        group      = "+",
        ellipsis   = "…",
        keys = {
          Up    = " ", Down  = " ", Left = " ", Right = " ",
          C     = "⌘ ", M    = "⌥ ", S    = "⇧ ",
          CR    = "⏎ ", Esc  = "⎈ ",
          Tab   = "⇥ ", BS   = "⌫ ",
          Space = "␣ ",
        },
      },
      win = {
        border   = "rounded",
        padding  = { 1, 2 },
        wo = { winblend = 10 },
      },
      layout = {
        width   = { min = 20 },
        spacing = 3,
      },
      show_help = true,
      show_keys = true,
      triggers  = {
        { "<auto>", mode = "nixsotc" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.add({
        -- Top-level groups with codicon/devicon glyphs from nerdfonts
        { "<leader>b",     group = "buffers",       icon = { icon = " ", color = "cyan"   } }, -- bookmark
        { "<leader>c",     group = "code",          icon = { icon = " ", color = "orange" } }, -- code brackets
        { "<leader>d",     group = "debug",         icon = { icon = " ", color = "red"    } }, -- debug
        { "<leader>f",     group = "find",          icon = { icon = " ", color = "blue"   } }, -- search
        { "<leader>g",     group = "git",           icon = { icon = " ", color = "green"  } }, -- git devicon
        { "<leader>l",     group = "lsp",           icon = { icon = " ", color = "yellow" } }, -- lightbulb
        { "<leader>s",     group = "splits",        icon = { icon = " ", color = "purple" } }, -- split horizontal
        { "<leader>t",     group = "terminal/test", icon = { icon = " ", color = "teal"   } }, -- terminal
        { "<leader>u",     group = "ui",            icon = { icon = " ", color = "cyan"   } }, -- paintcan
        { "<leader>x",     group = "trouble",       icon = { icon = " ", color = "red"    } }, -- warning
        { "<leader>h",     group = "harpoon",       icon = { icon = " ", color = "orange" } }, -- pin
        { "<leader>q",     group = "sessions",      icon = { icon = " ", color = "blue"   } }, -- save
        { "<leader><tab>", group = "tabs",          icon = { icon = " ", color = "purple" } }, -- multiple windows

        -- Git subgroups
        { "<leader>gh",    group = "hunks",         icon = { icon = " ", color = "green"  } }, -- diff
        { "<leader>gt",    group = "git-toggle",    icon = { icon = " ", color = "yellow" } }, -- refresh
        { "<leader>go",    group = "octo/github",   icon = { icon = " ", color = "purple" } }, -- github
        { "<leader>gf",    group = "git-find",      icon = { icon = " ", color = "blue"   } }, -- search

        -- LSP subgroups
        { "<leader>lw",    group = "workspace",     icon = { icon = " ", color = "blue"   } }, -- layers
        { "<leader>lp",    group = "peek",          icon = { icon = " ", color = "teal"   } }, -- eye

        -- Noice subgroup
        { "<leader>sn",    group = "noice",         icon = { icon = " ", color = "yellow" } }, -- bell

        -- Stage 7 groups
        { "<leader>s",     group = "splits/search/replace", icon = { icon = " ", color = "purple" } },
        { "<leader>sr",    group = "replace",       icon = { icon = " ", color = "red"    } },
        { "<leader>u",     group = "ui",            icon = { icon = " ", color = "cyan"   } },
        { "<leader>uu",    group = "undo",          icon = { icon = " ", color = "yellow" } },
        { "<leader>f",     group = "find",          icon = { icon = " ", color = "blue"   } },

        -- Stage 8 groups
        { "<leader>a",     group = "ai",           icon = { icon = " ", color = "purple" } },

        -- Visual mode
        { "<leader>",      group = "leader",        mode = "v" },
      })
    end,
  },
}
