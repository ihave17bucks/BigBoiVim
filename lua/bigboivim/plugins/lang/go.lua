-- BigBoiVim -- lang/go.lua

return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft    = { "go", "gomod", "gowork", "gotmpl" },
    build = ':lua require("go.install").update_all_sync()',
    opts  = {
      lsp_cfg           = false,  -- we handle gopls via lspconfig already
      lsp_gofumpt       = true,
      lsp_on_attach     = false,
      lsp_inlay_hints   = { enable = true },
      diagnostic        = { hdlr = false },
      icons             = { breakpoint = "", currentpos = "" },
      dap_debug         = true,
      dap_debug_keymap  = false,  -- manage our own keymaps
      textobjects       = false,  -- we use treesitter-textobjects
      test_runner       = "go",
      run_in_floaterm   = true,
      floaterm = {
        posititon    = "auto",
        width        = 0.45,
        height       = 0.98,
        title_colors = "nord",
      },
      luasnip           = true,
    },
    config = function(_, opts)
      require("go").setup(opts)

      -- Go-specific keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern  = { "go", "gomod" },
        callback = function(ev)
          local map = function(k, f, d)
            vim.keymap.set("n", k, f, { buffer = ev.buf, desc = "Go: " .. d })
          end
          map("<leader>gr",  "<cmd>GoRun<CR>",              "Run")
          map("<leader>gt",  "<cmd>GoTest<CR>",             "Test")
          map("<leader>gtf", "<cmd>GoTestFunc<CR>",         "Test function")
          map("<leader>gtc", "<cmd>GoTestCompile<CR>",      "Test compile")
          map("<leader>gcv", "<cmd>GoCoverage<CR>",         "Coverage")
          map("<leader>gfs", "<cmd>GoFillStruct<CR>",       "Fill struct")
          map("<leader>gfe", "<cmd>GoIfErr<CR>",            "Add if err")
          map("<leader>gat", "<cmd>GoAddTag<CR>",           "Add tags")
          map("<leader>grt", "<cmd>GoRmTag<CR>",            "Remove tags")
          map("<leader>gim", "<cmd>GoImpl<CR>",             "Implement interface")
          map("<leader>gge", "<cmd>GoGenerate<CR>",         "Go generate")
          map("<leader>gdc", "<cmd>GoDoc<CR>",              "Go doc")
        end,
      })

      -- Format on save for Go (gofumpt + goimports)
      local format_group = vim.api.nvim_create_augroup("bigboivim_go_format", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern  = "*.go",
        group    = format_group,
        callback = function()
          require("go.format").goimports()
        end,
      })
    end,
  },
}
