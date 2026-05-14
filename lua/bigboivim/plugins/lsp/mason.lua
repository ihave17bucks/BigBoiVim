-- BigBoiVim -- lsp/mason.lua

return {
  -- Mason: installs LSP servers, formatters, linters, DAP adapters
  {
    "williamboman/mason.nvim",
    cmd   = "Mason",
    build = ":MasonUpdate",
    opts  = {
      ui = {
        border = "rounded",
        icons  = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      -- Auto-install everything on first launch
      local ensure_installed = {
        -- LSP servers (mason package names)
        "lua-language-server", "stylua",
        "pyright", "ruff",
        "typescript-language-server", "eslint-lsp",
        "rust-analyzer", "taplo",
        "gopls",
        "clangd", "clang-format",
        "bash-language-server", "shellcheck", "shfmt",
        "json-lsp",
        "yaml-language-server",
        "marksman",
        "dockerfile-language-server",
        "docker-compose-language-service",
        -- Formatters
        "prettierd", "black", "isort", "gofumpt",
        -- Linters
        "selene", "markdownlint",
      }

      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(ensure_installed) do
          local ok, p = pcall(mr.get_package, tool)
          if ok and not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },

  -- Bridge: mason <-> lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "lua_ls", "pyright", "ts_ls", "eslint",
        "rust_analyzer", "gopls", "clangd",
        "bashls", "jsonls", "yamlls",
        "marksman", "taplo",
        "dockerls", "docker_compose_language_service",
      },
    },
  },
}
