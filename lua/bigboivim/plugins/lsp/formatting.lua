-- BigBoiVim -- lsp/formatting.lua

return {
  -- conform.nvim: formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd   = { "ConformInfo" },
    keys  = {
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format file",
      },
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "v",
        desc = "Format selection",
      },
    },
    opts = {
      formatters_by_ft = {
        lua        = { "stylua" },
        python     = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json       = { "prettierd" },
        jsonc      = { "prettierd" },
        yaml       = { "prettierd" },
        markdown   = { "prettierd" },
        html       = { "prettierd" },
        css        = { "prettierd" },
        scss       = { "prettierd" },
        rust       = { "rustfmt" },
        go         = { "gofumpt", "goimports" },
        c          = { "clang_format" },
        cpp        = { "clang_format" },
        sh         = { "shfmt" },
        toml       = { "taplo" },
        ["_"]      = { "trim_whitespace" },
      },
      -- Format on save
      format_on_save = function(bufnr)
        -- Disable for files without a formatter or very large files
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        if vim.api.nvim_buf_line_count(bufnr) > 5000 then return end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters = {
        shfmt = { args = { "-i", "2", "-ci" } },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)

      -- Toggle format-on-save
      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          vim.b.disable_autoformat = not vim.b.disable_autoformat
          vim.notify("Buffer format on save: " .. (vim.b.disable_autoformat and "OFF" or "ON"))
        else
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          vim.notify("Global format on save: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
        end
      end, { desc = "Toggle format on save", bang = true })

      vim.keymap.set("n", "<leader>uF", "<cmd>FormatToggle<CR>",  { desc = "Toggle format on save (global)" })
      vim.keymap.set("n", "<leader>uf", "<cmd>FormatToggle!<CR>", { desc = "Toggle format on save (buffer)" })
    end,
  },

  -- nvim-lint: linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        lua        = { "selene" },
        python     = { "ruff" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        markdown   = { "markdownlint" },
        sh         = { "shellcheck" },
      }

      -- Run linters on save and when leaving insert mode
      local lint_group = vim.api.nvim_create_augroup("bigboivim_lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group    = lint_group,
        callback = function()
          -- Don't lint if no linter available for this ft
          local names = lint._resolve_linter_by_ft(vim.bo.filetype)
          if #names == 0 then return end
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function() lint.try_lint() end, { desc = "Run linter" })
    end,
  },

  -- trouble.nvim: beautiful diagnostics panel
  {
    "folke/trouble.nvim",
    cmd  = { "Trouble" },
    keys = {
      { "<leader>ld",  "<cmd>Trouble diagnostics toggle<CR>",                        desc = "Diagnostics (Trouble)" },
      { "<leader>lD",  "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",           desc = "Buffer diagnostics (Trouble)" },
      { "<leader>ls",  "<cmd>Trouble symbols toggle focus=false<CR>",                desc = "Symbols (Trouble)" },
      { "<leader>lS",  "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP references (Trouble)" },
      { "<leader>xL",  "<cmd>Trouble loclist toggle<CR>",                            desc = "Location list (Trouble)" },
      { "<leader>xQ",  "<cmd>Trouble qflist toggle<CR>",                             desc = "Quickfix (Trouble)" },
    },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
  },
}
