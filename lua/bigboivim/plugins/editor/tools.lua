-- BigBoiVim -- editor/tools.lua
-- Spectre, refactoring, yanky, dial, visual multi

return {
  -- Find and replace across project (with regex + structural search)
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd   = "Spectre",
    keys  = {
      { "<leader>sr",  function() require("spectre").open() end,                                desc = "Spectre (project replace)" },
      { "<leader>sw",  function() require("spectre").open_visual({ select_word = true }) end,   desc = "Spectre: word under cursor" },
      { "<leader>sw",  function() require("spectre").open_visual() end,                         mode = "v", desc = "Spectre: selection" },
      { "<leader>sf",  function() require("spectre").open_file_search({ select_word = true }) end, desc = "Spectre: replace in file" },
    },
    opts  = {
      color_devicons    = true,
      open_cmd          = "vnew",
      live_update       = false,
      line_sep_start    = "┌──────────────────────────────",
      result_padding    = "│  ",
      line_sep          = "└──────────────────────────────",
      highlight         = { ui = "String", search = "DiffChange", replace = "DiffAdd" },
      find_engine = {
        ["rg"] = {
          cmd  = "rg",
          args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
          options = {
            ["ignore-case"]   = { value = "--ignore-case",   icon = "[I]", desc = "ignore case" },
            ["hidden"]        = { value = "--hidden",        icon = "[H]", desc = "hidden files" },
          },
        },
      },
      replace_engine = {
        ["sed"] = { cmd = "sed", args = nil },
      },
      default = {
        find    = { cmd = "rg",  options = { "ignore-case" } },
        replace = { cmd = "sed" },
      },
    },
  },

  -- Better yank: cycle history, persistent across sessions
  {
    "gbprod/yanky.nvim",
    event        = { "BufReadPost", "BufNewFile" },
    dependencies = { "kkharji/sqlite.lua" },
    keys  = {
      { "y",   "<Plug>(YankyYank)",                 mode = { "n", "x" }, desc = "Yank" },
      { "p",   "<Plug>(YankyPutAfter)",             mode = { "n", "x" }, desc = "Put after" },
      { "P",   "<Plug>(YankyPutBefore)",            mode = { "n", "x" }, desc = "Put before" },
      { "gp",  "<Plug>(YankyGPutAfter)",            mode = { "n", "x" }, desc = "GPut after" },
      { "gP",  "<Plug>(YankyGPutBefore)",           mode = { "n", "x" }, desc = "GPut before" },
      { "<C-p>", "<Plug>(YankyCycleForward)",                             desc = "Cycle yank forward" },
      { "<C-n>", "<Plug>(YankyCycleBackward)",                            desc = "Cycle yank backward" },
      { "<leader>fy", function() require("telescope").extensions.yank_history.yank_history() end, desc = "Yank history" },
    },
    opts = {
      ring = {
        history_length    = 100,
        storage           = "sqlite",
        storage_path      = vim.fn.stdpath("data") .. "/databases/yanky.db",
        sync_with_numbered_registers = true,
        cancel_event      = "update",
        ignore_registers  = { "_" },
        update_register_on_cycle = false,
      },
      picker = {
        select = { action = nil },
        telescope = {
          use_default_mappings = true,
          mappings = nil,
        },
      },
      system_clipboard = { sync_with_ring = true },
      highlight        = { on_put = true, on_yank = true, timer = 150 },
      preserve_cursor_position = { enabled = true },
    },
  },

  -- Dial: increment/decrement almost anything (dates, booleans, hex, etc.)
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>",  function() require("dial.map").manipulate("increment", "normal")  end, desc = "Increment" },
      { "<C-x>",  function() require("dial.map").manipulate("decrement", "normal")  end, desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end, desc = "Increment (g)" },
      { "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end, desc = "Decrement (g)" },
      { "<C-a>",  function() require("dial.map").manipulate("increment", "visual")  end, mode = "v", desc = "Increment" },
      { "<C-x>",  function() require("dial.map").manipulate("decrement", "visual")  end, mode = "v", desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end, mode = "v", desc = "Increment (g)" },
      { "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end, mode = "v", desc = "Decrement (g)" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.integer.alias.octal,
          augend.integer.alias.binary,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%m/%d/%Y"],
          augend.date.alias["%H:%M"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "and", "or" },          word = true, cyclic = true }),
          augend.constant.new({ elements = { "&&", "||" },           word = false, cyclic = true }),
          augend.constant.new({ elements = { "true", "false" },      word = true, cyclic = true }),
          augend.constant.new({ elements = { "True", "False" },      word = true, cyclic = true }),
          augend.constant.new({ elements = { "yes", "no" },          word = true, cyclic = true }),
          augend.constant.new({ elements = { "on", "off" },          word = true, cyclic = true }),
          augend.constant.new({ elements = { "enable", "disable" },  word = true, cyclic = true }),
          augend.constant.new({ elements = { "left", "right" },      word = true, cyclic = true }),
          augend.constant.new({ elements = { "up", "down" },         word = true, cyclic = true }),
          augend.constant.new({ elements = { "min", "max" },         word = true, cyclic = true }),
          augend.constant.new({ elements = { "debug", "info", "warn", "error" }, word = true, cyclic = true }),
        },
      })
    end,
  },

  -- Multiple cursors (vim-visual-multi)
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPost", "BufNewFile" },
    init  = function()
      vim.g.VM_maps = {
        ["Find Under"]         = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
        ["Add Cursor Up"]      = "<C-S-k>",
        ["Add Cursor Down"]    = "<C-S-j>",
        ["Select All"]         = "<C-S-n>",
        ["Skip Region"]        = "<C-x>",
      }
      vim.g.VM_theme                    = "ocean"
      vim.g.VM_highlight_matches        = "underline"
      vim.g.VM_show_warnings            = 0
      vim.g.VM_silent_exit              = 1
    end,
  },
}
