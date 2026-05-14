-- BigBoiVim -- terminal/toggleterm.lua

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd     = { "ToggleTerm", "TermExec" },
    keys    = {
      { "<leader>tt",  "<cmd>ToggleTerm direction=float<CR>",      desc = "Terminal (float)" },
      { "<leader>th",  "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal (horizontal)" },
      { "<leader>tv",  "<cmd>ToggleTerm direction=vertical<CR>",   desc = "Terminal (vertical)" },
      { "<C-\\>",      "<cmd>ToggleTerm direction=float<CR>",      desc = "Toggle float terminal", mode = { "n", "t" } },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then return 16
        elseif term.direction == "vertical" then return math.floor(vim.o.columns * 0.4)
        end
      end,
      open_mapping      = nil,
      hide_numbers      = true,
      autochdir         = true,
      shade_terminals   = true,
      shading_factor    = 2,
      start_in_insert   = true,
      insert_mappings   = false,
      terminal_mappings = true,
      persist_size      = true,
      persist_mode      = true,
      direction         = "float",
      close_on_exit     = true,
      shell             = vim.o.shell,
      auto_scroll       = true,
      float_opts = {
        border   = "curved",
        winblend = 8,
        width    = function() return math.floor(vim.o.columns * 0.85) end,
        height   = function() return math.floor(vim.o.lines * 0.80) end,
        title_pos = "center",
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local function set_terminal_keymaps()
        local map = function(k, v)
          vim.keymap.set("t", k, v, { buffer = 0, silent = true })
        end
        map("<Esc><Esc>", "<C-\\><C-n>")
        map("<C-h>",      "<C-\\><C-n><C-w>h")
        map("<C-j>",      "<C-\\><C-n><C-w>j")
        map("<C-k>",      "<C-\\><C-n><C-w>k")
        map("<C-l>",      "<C-\\><C-n><C-w>l")
        map("<C-\\>",     "<cmd>ToggleTerm<CR>")
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern  = "term://*toggleterm#*",
        callback = set_terminal_keymaps,
      })

      local Terminal = require("toggleterm.terminal").Terminal

      local lazygit = Terminal:new({
        cmd       = "lazygit",
        dir       = "git_dir",
        direction = "float",
        hidden    = true,
        float_opts = {
          border = "curved",
          width  = function() return math.floor(vim.o.columns * 0.95) end,
          height = function() return math.floor(vim.o.lines * 0.92) end,
        },
        on_open  = function(term)
          vim.cmd("startinsert!")
          vim.keymap.set("n", "q", function() term:toggle() end, { buffer = term.bufnr, silent = true })
        end,
        on_close = function() vim.cmd("startinsert!") end,
      })

      local btop = Terminal:new({
        cmd       = "btop",
        direction = "float",
        hidden    = true,
        float_opts = {
          border = "curved",
          width  = function() return math.floor(vim.o.columns * 0.95) end,
          height = function() return math.floor(vim.o.lines * 0.92) end,
        },
      })

      _G.BigBoiToggleLazygit = function() lazygit:toggle() end
      _G.BigBoiToggleBtop    = function() btop:toggle() end

      vim.keymap.set("n", "<leader>tg", "<cmd>lua BigBoiToggleLazygit()<CR>", { desc = "Lazygit" })
      vim.keymap.set("n", "<leader>tm", "<cmd>lua BigBoiToggleBtop()<CR>",    { desc = "btop" })
    end,
  },
}
