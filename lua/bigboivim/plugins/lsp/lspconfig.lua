-- BigBoiVim -- lsp/lspconfig.lua
-- Uses vim.lsp.config (Neovim 0.11+ native API) instead of the deprecated
-- require('lspconfig') framework.

return {
  {
    "neovim/nvim-lspconfig",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
      "b0o/SchemaStore.nvim",
    },
    config = function()
      -- ── Diagnostics ───────────────────────────────────────────────────────
      vim.diagnostic.config({
        severity_sort    = true,
        underline        = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source  = "if_many",
          prefix  = function(diagnostic)
            local icons = { ERROR = " ", WARN = " ", INFO = " ", HINT = " " }
            return icons[vim.diagnostic.severity[diagnostic.severity]] or "● "
          end,
        },
        float  = { border = "rounded", source = "always", header = "", prefix = "" },
        signs  = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
      })

      -- ── on_attach ─────────────────────────────────────────────────────────
      vim.api.nvim_create_autocmd("LspAttach", {
        group    = vim.api.nvim_create_augroup("bigboivim_lsp_attach", { clear = true }),
        callback = function(event)
          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then return end

          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
          end

          map("gd",  vim.lsp.buf.definition,      "Go to definition")
          map("gD",  vim.lsp.buf.declaration,     "Go to declaration")
          map("gr",  vim.lsp.buf.references,      "Go to references")
          map("gI",  vim.lsp.buf.implementation,  "Go to implementation")
          map("gy",  vim.lsp.buf.type_definition, "Go to type definition")
          map("K",   vim.lsp.buf.hover,           "Hover docs")
          map("gK",  vim.lsp.buf.signature_help,  "Signature help")

          map("<leader>lr", vim.lsp.buf.rename,      "Rename symbol")
          map("<leader>la", vim.lsp.buf.code_action, "Code action")
          map("<leader>lf", function()
            -- prefer conform, fall back to LSP
            local ok, conform = pcall(require, "conform")
            if ok then conform.format({ async = true, lsp_fallback = true })
            else vim.lsp.buf.format({ async = true }) end
          end, "Format file")

          map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
          map("[d",         vim.diagnostic.goto_prev,  "Prev diagnostic")
          map("]d",         vim.diagnostic.goto_next,  "Next diagnostic")

          map("<leader>lwa", vim.lsp.buf.add_workspace_folder,    "Add workspace folder")
          map("<leader>lwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
          map("<leader>lwl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "List workspace folders")

          -- Inlay hints (Neovim 0.10+)
          if vim.fn.has("nvim-0.10") == 1
            and client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true)
            map("<leader>lh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "Toggle inlay hints")
          end

          -- Document highlight on cursor hold
          if client.supports_method("textDocument/documentHighlight") then
            local hl_group = vim.api.nvim_create_augroup("bigboivim_lsp_hl_" .. bufnr, { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = bufnr, group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              buffer = bufnr, group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- ── Capabilities (blink.cmp-extended) ────────────────────────────────
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- ── Server configs via vim.lsp.config (Neovim 0.11 native API) ───────
      -- Servers managed by dedicated plugins — skip here
      local skip = { rust_analyzer = true, ts_ls = true }

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime     = { version = "LuaJIT" },
              workspace   = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
              },
              completion  = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } },
              hint        = { enable = true },
              telemetry   = { enable = false },
            },
          },
        },

        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths        = true,
                diagnosticMode         = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode       = "standard",
              },
            },
          },
        },

        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo       = { allFeatures = true, loadOutDirsFromCheck = true },
              checkOnSave = { command = "clippy" },
            },
          },
        },

        gopls = {
          settings = {
            gopls = {
              gofumpt  = true,
              analyses = {
                nilness      = true,
                unusedparams = true,
                unusedwrite  = true,
                useany       = true,
              },
              hints = {
                assignVariableTypes    = true,
                compositeLiteralFields = true,
                compositeLiteralTypes  = true,
                constantValues         = true,
                functionTypeParameters = true,
                parameterNames         = true,
                rangeVariableTypes     = true,
              },
            },
          },
        },

        clangd = {
          cmd = {
            "clangd", "--background-index", "--clang-tidy",
            "--header-insertion=iwyu", "--completion-style=detailed",
            "--function-arg-placeholders",
          },
          init_options = {
            usePlaceholders    = true,
            completeUnimported = true,
            clangdFileStatus   = true,
          },
        },

        jsonls = {
          settings = {
            json = {
              schemas  = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = { enable = false, url = "" },
              schemas     = require("schemastore").yaml.schemas(),
            },
          },
        },

        ts_ls   = {},
        bashls  = {},
        marksman = {},
        taplo   = {},
        dockerls = {},
        eslint  = {},
        docker_compose_language_service = {},
      }

      -- Apply via vim.lsp.config + vim.lsp.enable (Neovim 0.11 native)
      for server, config in pairs(servers) do
        if not skip[server] then
          config.capabilities = capabilities
          vim.lsp.config(server, config)
          vim.lsp.enable(server)
        end
      end
    end,
  },

  { "b0o/SchemaStore.nvim", lazy = true, version = false },
}
