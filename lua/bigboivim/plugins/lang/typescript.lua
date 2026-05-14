-- BigBoiVim -- lang/typescript.lua

return {
  -- typescript-tools: native TS server, much faster than ts_ls via lspconfig
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft           = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    opts = {
      on_attach = function(_, bufnr)
        local map = function(k, f, d)
          vim.keymap.set("n", k, f, { buffer = bufnr, desc = "TS: " .. d })
        end
        map("<leader>to",  "<cmd>TSToolsOrganizeImports<CR>",    "Organize imports")
        map("<leader>ts",  "<cmd>TSToolsSortImports<CR>",        "Sort imports")
        map("<leader>tu",  "<cmd>TSToolsRemoveUnusedImports<CR>","Remove unused imports")
        map("<leader>tU",  "<cmd>TSToolsRemoveUnused<CR>",       "Remove unused statements")
        map("<leader>ta",  "<cmd>TSToolsAddMissingImports<CR>",  "Add missing imports")
        map("<leader>tf",  "<cmd>TSToolsFixAll<CR>",             "Fix all")
        map("<leader>tg",  "<cmd>TSToolsGoToSourceDefinition<CR>","Go to source definition")
        map("<leader>tr",  "<cmd>TSToolsRenameFile<CR>",         "Rename file")
        map("<leader>tR",  "<cmd>TSToolsFileReferences<CR>",     "File references")
      end,
      settings = {
        separate_diagnostic_server              = true,
        publish_diagnostic_on                   = "insert_leave",
        expose_as_code_action                   = "all",
        tsserver_path                           = nil,
        tsserver_plugins                        = {},
        tsserver_max_memory                     = "auto",
        tsserver_locale                         = "en",
        complete_function_calls                 = true,
        include_completions_with_insert_text    = true,
        code_lens                               = "off",
        disable_member_code_lens                = true,
        jsx_close_tag = {
          enable    = true,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
        tsserver_file_preferences = {
          includeInlayParameterNameHints                 = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints         = true,
          includeInlayVariableTypeHints                  = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints       = true,
          includeInlayFunctionLikeReturnTypeHints        = true,
          includeInlayEnumMemberValueHints               = true,
          importModuleSpecifierPreference                = "non-relative",
          quotePreference                                = "auto",
        },
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath    = false,
        },
      },
    },
  },
}
