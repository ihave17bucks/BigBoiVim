-- BigBoiVim -- navigation/harpoon.lua

return {
  {
    "ThePrimeagen/harpoon",
    branch       = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local harpoon = require("harpoon")
      local keys = {
        { "<leader>ha", function() harpoon:list():add() end,     desc = "Harpoon: add file" },
        { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: menu" },
        { "<leader>hc", function() harpoon:list():clear() end,   desc = "Harpoon: clear" },
        { "<leader>h.", function() harpoon:list():next() end,     desc = "Harpoon: next" },
        { "<leader>h,", function() harpoon:list():prev() end,     desc = "Harpoon: prev" },
      }
      -- Slots 1-5 on <leader>1 through <leader>5
      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function() harpoon:list():select(i) end,
          desc = "Harpoon: go to file " .. i,
        })
      end
      return keys
    end,
    opts = {
      settings = {
        save_on_toggle   = true,
        sync_on_ui_close = true,
        key = function()
          return vim.loop.cwd()
        end,
      },
    },
    config = function(_, opts)
      require("harpoon"):setup(opts)
    end,
  },
}
