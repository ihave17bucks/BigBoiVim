-- BigBoiVim -- git/neogit.lua

return {
  {
    "NeogitOrg/neogit",
    cmd          = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>gg", function() require("neogit").open() end,                          desc = "Neogit" },
      { "<leader>gG", function() require("neogit").open({ kind = "split" }) end,        desc = "Neogit (split)" },
      { "<leader>gc", function() require("neogit").open({ "commit" }) end,              desc = "Neogit commit" },
      { "<leader>gp", function() require("neogit").open({ "push" }) end,                desc = "Neogit push" },
      { "<leader>gl", function() require("neogit").open({ "pull" }) end,                desc = "Neogit pull" },
    },
    opts = {
      kind                      = "tab",     -- open in a full tab like Magit
      disable_hint              = false,
      disable_context_highlighting = false,
      disable_signs             = false,
      graph_style               = "unicode",
      git_services = {
        ["github.com"]    = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        ["gitlab.com"]    = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
        ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
      },
      floating_border           = "rounded",
      remember_settings         = true,
      use_per_project_settings  = true,
      ignored_settings          = { "NeogitPushPopup--force-with-lease", "NeogitPushPopup--force" },
      highlight = {
        italic  = true,
        bold    = true,
        underline = true,
      },
      use_default_keymaps       = true,
      auto_refresh              = true,
      sort_branches             = "-committerdate",
      integrations = {
        telescope  = true,
        diffview   = true,
      },
      sections = {
        untracked = { folded = false, hidden = false },
        unstaged  = { folded = false, hidden = false },
        staged    = { folded = false, hidden = false },
        stashes   = { folded = true,  hidden = false },
        unpulled_upstream  = { folded = true,  hidden = false },
        unmerged_upstream  = { folded = false, hidden = false },
        unpulled_pushremote = { folded = true,  hidden = false },
        unmerged_pushremote = { folded = false, hidden = false },
        recent    = { folded = true,  hidden = false },
        rebase    = { folded = true,  hidden = false },
      },
    },
  },
}
