-- BigBoiVim -- lang/rust.lua

return {
  -- rustaceanvim: replaces the basic rust_analyzer lspconfig setup
  -- Must tell lspconfig NOT to also set up rust_analyzer
  {
    "mrcjkb/rustaceanvim",
    version      = "^5",
    ft           = { "rust" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      tools = {
        hover_actions = { replace_builtin_hover = true },
        code_action_group = { enabled = true },
        float_win_config = { border = "rounded" },
      },
      server = {
        on_attach = function(_, bufnr)
          local map = function(k, f, d)
            vim.keymap.set("n", k, f, { buffer = bufnr, desc = "Rust: " .. d })
          end

          -- rustaceanvim-specific commands
          map("<leader>re",  function() vim.cmd.RustLsp("expandMacro") end,     "Expand macro")
          map("<leader>rc",  function() vim.cmd.RustLsp("openCargo") end,       "Open Cargo.toml")
          map("<leader>rp",  function() vim.cmd.RustLsp("parentModule") end,    "Parent module")
          map("<leader>rr",  function() vim.cmd.RustLsp("runnables") end,       "Runnables")
          map("<leader>rd",  function() vim.cmd.RustLsp("debuggables") end,     "Debuggables")
          map("<leader>rt",  function() vim.cmd.RustLsp("testables") end,       "Testables")
          map("<leader>rj",  function() vim.cmd.RustLsp("joinLines") end,       "Join lines")
          map("<leader>rh",  function() vim.cmd.RustLsp("hover", "actions") end, "Hover actions")
          map("<leader>rm",  function() vim.cmd.RustLsp("moveItem", "down") end, "Move item down")
          map("<leader>rM",  function() vim.cmd.RustLsp("moveItem", "up") end,   "Move item up")
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures         = true,
              loadOutDirsFromCheck = true,
              runBuildScripts     = true,
            },
            checkOnSave = { command = "clippy", allFeatures = true },
            procMacro = {
              enable  = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            inlayHints = {
              bindingModeHints     = { enable = false },
              chainingHints        = { enable = true },
              closingBraceHints    = { enable = true, minLines = 25 },
              closureReturnTypeHints = { enable = "with_block" },
              lifetimeElisionHints = { enable = "skip_trivial", useParameterNames = false },
              maxLength            = { enable = true, value = 25 },
              parameterHints       = { enable = true },
              typeHints            = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },

  -- crates.nvim: Cargo.toml inline version info and management
  {
    "saecki/crates.nvim",
    event  = { "BufRead Cargo.toml" },
    tag    = "stable",
    opts   = {
      completion = {
        cmp    = { enabled = false },
        crates = { enabled = true, max_results = 8, min_chars = 3 },
      },
      lsp = {
        enabled         = true,
        actions         = true,
        completion      = true,
        hover           = true,
      },
      popup = { border = "rounded" },
    },
    config = function(_, opts)
      require("crates").setup(opts)

      -- Wire crates as a blink source when in Cargo.toml
      vim.api.nvim_create_autocmd("BufRead", {
        pattern  = "Cargo.toml",
        callback = function()
          local map = function(k, f, d)
            vim.keymap.set("n", k, f, { buffer = true, desc = "Crates: " .. d })
          end
          map("<leader>ct",  require("crates").toggle,                   "Toggle")
          map("<leader>cr",  require("crates").reload,                   "Reload")
          map("<leader>cv",  require("crates").show_versions_popup,      "Show versions")
          map("<leader>cf",  require("crates").show_features_popup,      "Show features")
          map("<leader>cd",  require("crates").show_dependencies_popup,  "Show dependencies")
          map("<leader>cu",  require("crates").update_crate,             "Update crate")
          map("<leader>cU",  require("crates").update_all_crates,        "Update all crates")
          map("<leader>cH",  require("crates").open_homepage,            "Open homepage")
          map("<leader>cR",  require("crates").open_repository,          "Open repository")
          map("<leader>cD",  require("crates").open_documentation,       "Open docs.rs")
        end,
      })
    end,
  },
}
