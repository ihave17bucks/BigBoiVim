-- BigBoiVim -- ai/init.lua
-- avante (Cursor-style inline AI), codecompanion (chat + actions), copilot (ghost text)

return {
  -- Copilot: ghost-text completions via blink.cmp source
  {
    "zbirenbaum/copilot.lua",
    lazy   = false,
    priority = 800,
    keys   = {
      { "<leader>ac", "<cmd>Copilot toggle<CR>",  desc = "AI: Toggle Copilot" },
      { "<leader>ap", "<cmd>Copilot panel<CR>",   desc = "AI: Copilot panel" },
    },
    opts   = {
      panel          = { enabled = false },      -- using blink source instead
      suggestion     = { enabled = false },      -- using blink source instead
      filetypes      = {
        yaml         = true,
        markdown     = true,
        help         = false,
        gitcommit    = true,
        gitrebase    = false,
        hgcommit     = false,
        svn          = false,
        cvs          = false,
        ["."]        = false,
      },
      copilot_node_command = "node",
      server_opts_overrides = {},
    },
  },

  -- copilot-cmp: wire copilot into blink.cmp as a source
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- avante.nvim: Cursor-style AI editing panel
  {
    "yetone/avante.nvim",
    cmd          = { "AvanteAsk", "AvanteEdit", "AvanteChat", "AvanteToggle", "AvanteFocus", "AvanteRefresh" },
    version      = false,
    build        = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      { "HakonHarnes/img-clip.nvim", event = "VeryLazy",
        opts = { default = { embed_image_as_base64 = false, prompt_for_file_name = false,
                             drag_and_drop = { insert_mode = true } } } },
      { "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft   = { "markdown", "Avante" } },
    },
    keys = {
      { "<leader>aa",  function() require("avante.api").ask() end,                     desc = "AI: Ask avante",           mode = { "n", "v" } },
      { "<leader>ae",  function() require("avante.api").edit() end,                    desc = "AI: Edit with avante",     mode = "v" },
      { "<leader>ar",  function() require("avante.api").refresh() end,                 desc = "AI: Refresh avante",       mode = "n" },
      { "<leader>af",  function() require("avante.api").focus() end,                   desc = "AI: Focus avante panel",   mode = "n" },
      { "<leader>at",  function() require("avante").toggle() end,                      desc = "AI: Toggle avante",        mode = "n" },
    },
    opts = {
      provider    = "claude",
      auto_suggestions_provider = "claude",
      providers = {
        copilot = {
          model = "claude-sonnet-4-5",
        },
        claude = {
          endpoint           = "https://api.anthropic.com",
          model              = "claude-sonnet-4-5",
          timeout            = 30000,
          extra_request_body = { temperature = 0, max_tokens = 8096 },
        },
        openai = {
          endpoint           = "https://api.openai.com/v1",
          model              = "gpt-4o",
          timeout            = 30000,
          extra_request_body = { temperature = 0, max_tokens = 8096 },
        },
      },
      behaviour = {
        auto_suggestions        = false,
        auto_set_highlight_group = true,
        auto_set_keymaps        = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff           = true,
      },
      mappings = {
        diff = {
          ours     = "co",
          theirs   = "ct",
          all_theirs = "ca",
          both     = "cb",
          cursor   = "cc",
          next     = "]x",
          prev     = "[x",
        },
        suggestion = {
          accept   = "<M-l>",
          next     = "<M-]>",
          prev     = "<M-[>",
          dismiss  = "<C-]>",
        },
        jump = { next = "]]", prev = "[[" },
        submit = { normal = "<CR>", insert = "<C-s>" },
      },
      hints = { enabled = true },
      windows = {
        position         = "right",
        wrap             = true,
        width            = 35,
        sidebar_header   = {
          enabled  = true,
          align    = "center",
          rounded  = true,
        },
        input = {
          prefix   = " ",
          height   = 8,
        },
        edit = {
          border   = "rounded",
          start_insert = true,
        },
        ask = {
          floating    = false,
          border      = "rounded",
          start_insert = true,
          focus_on_apply = "ours",
        },
      },
      highlights = {
        diff = { current = "DiffText", incoming = "DiffAdd" },
      },
      diff = {
        autojump        = true,
        list_opener     = "copen",
        override_timeoutlen = 500,
      },
    },
  },

  -- codecompanion: chat interface + inline actions + slash commands
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
    },
    cmd  = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
    keys = {
      { "<leader>ai",  "<cmd>CodeCompanionChat Toggle<CR>",   desc = "AI: CodeCompanion chat",    mode = { "n", "v" } },
      { "<leader>aI",  "<cmd>CodeCompanionActions<CR>",       desc = "AI: CodeCompanion actions", mode = { "n", "v" } },
      { "<leader>aA",  "<cmd>CodeCompanionChat Add<CR>",      desc = "AI: Add to chat",           mode = "v" },
    },
    opts = {
      strategies = {
        chat = {
          adapter  = "copilot",
          roles    = { llm = "  BigBoiVim AI", user = "  You" },
          keymaps  = {
            send          = { modes = { n = "<CR>", i = "<C-s>" } },
            close         = { modes = { n = "q" } },
            stop          = { modes = { n = "<C-c>" } },
            clear         = { modes = { n = "<C-l>" } },
            codeblock     = { modes = { n = "<C-b>" } },
            yank_code     = { modes = { n = "gy" } },
            pin           = { modes = { n = "gp" } },
            watch         = { modes = { n = "gw" } },
            next_header   = { modes = { n = "]]" } },
            prev_header   = { modes = { n = "[[" } },
          },
          slash_commands = {
            ["buffer"]  = { callback = "strategies.chat.slash_commands.buffer",  description = "Insert open buffers",   opts = { provider = "telescope", contains_code = true } },
            ["file"]    = { callback = "strategies.chat.slash_commands.file",    description = "Insert file contents",  opts = { provider = "telescope", contains_code = true } },
            ["help"]    = { callback = "strategies.chat.slash_commands.help",    description = "Insert help content",   opts = { provider = "telescope", contains_code = false } },
            ["symbols"] = { callback = "strategies.chat.slash_commands.symbols", description = "Insert symbol info",    opts = { contains_code = true } },
            ["terminal"] = { callback = "strategies.chat.slash_commands.terminal", description = "Insert terminal output", opts = { contains_code = false } },
          },
        },
        inline  = { adapter = "copilot" },
        agent   = { adapter = "copilot" },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = { model = { default = "claude-sonnet-4-5" } },
          })
        end,
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = { model = { default = "claude-sonnet-4-5" } },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = { model = { default = "gpt-4o" } },
          })
        end,
      },
      display = {
        action_palette = { width = 95, height = 10, prompt = "Prompt ",
                           provider = "telescope", opts = { show_default_action_palette = true } },
        chat = {
          window = { layout = "vertical", width = 0.35, height = 0.5,
                     relative = "editor", border = "rounded", full_height = true },
          intro_message = "  BigBoiVim AI — what are we building?",
          show_header_separator = false,
          separator      = "─",
          show_references = true,
          show_settings  = false,
          show_token_count = true,
          token_count    = function(tokens, adapter)
            return " (" .. tokens .. " tokens)"
          end,
        },
        diff = {
          enabled        = true,
          close_chat_at  = 240,
          layout         = "vertical",
          opts           = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider       = "mini_diff",
        },
        inline = { layout = "vertical" },
      },
      opts = {
        log_level              = "ERROR",
        send_code              = true,
        silent                 = true,
        use_default_actions    = true,
        use_default_prompt_library = true,
      },
    },
  },
}
