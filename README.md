<div align="center">

```
▀█████████▄   ▄█     ▄██████▄  ▀█████████▄   ▄██████▄   ▄█   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄
  ███    ███ ███    ███    ███   ███    ███ ███    ███ ███  ███    ███ ███  ▄██▀▀▀███▀▀▀██▄
  ███    ███ ███▌   ███    █▀    ███    ███ ███    ███ ███▌ ███    ███ ███▌ ███   ███   ███
 ▄███▄▄▄██▀  ███▌  ▄███         ▄███▄▄▄██▀  ███    ███ ███▌ ███    ███ ███▌ ███   ███   ███
▀▀███▀▀▀██▄  ███▌ ▀▀███ ████▄  ▀▀███▀▀▀██▄  ███    ███ ███▌ ███    ███ ███▌ ███   ███   ███
  ███    ██▄ ███    ███    ███   ███    ██▄ ███    ███ ███  ███    ███ ███  ███   ███   ███
  ███    ███ ███    ███    ███   ███    ███ ███    ███ ███  ███    ███ ███  ███   ███   ███
▄█████████▀  █▀     ████████▀  ▄█████████▀   ▀██████▀  █▀    ▀██████▀  █▀    ▀█   ███   █▀
```

**The maximalist Neovim distribution. If in doubt, ship it.**

![Neovim](https://img.shields.io/badge/Neovim-0.11+-57A143?style=flat-square&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-5.1-2C2D72?style=flat-square&logo=lua&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)

</div>

---

## Philosophy

Most Neovim configs optimize for being slim. BigBoiVim does the opposite, it bundles every serious tool a developer could need, pre-wired and ready to go. Zero configuration required on your end.

## Requirements

| Tool | Why |
|------|-----|
| Neovim 0.11+ | native `vim.lsp.config` API |
| Git | plugin cloning |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Telescope grep |
| [fd](https://github.com/sharkdp/fd) | Telescope file search |
| [Node.js](https://nodejs.org) | Copilot, typescript-tools, markdown-preview |
| [lazygit](https://github.com/jesseduffield/lazygit) | `<leader>tg` terminal |
| A [Nerd Font](https://www.nerdfonts.com) | icons everywhere |
| `make` | avante.nvim build step |
| [yarn](https://yarnpkg.com) | markdown-preview.nvim build step |

Optional: `ANTHROPIC_API_KEY` in your env for avante's Claude backend.

## Install

```bash
# Back up existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone BigBoiVim
git clone https://github.com/ihave17bucks/BigBoiVim ~/.config/nvim

# Launch and then lazy.nvim bootstraps itself on first run
nvim
```

On first launch, Mason will auto-install all LSP servers and formatters in the background. Grab a coffee.

---

## What's Inside

### UI
| Plugin | Role |
|--------|------|
| catppuccin/nvim | Mocha colorscheme, pre-configured for every plugin |
| lualine.nvim | Global statusline with mode, git, LSP, macro recording |
| bufferline.nvim | Tabbed buffer bar with per-buffer diagnostics |
| neo-tree.nvim | Sidebar file explorer |
| noice.nvim | Floating cmdline, messages, and LSP popups |
| which-key.nvim | Every keymap documented, grouped by prefix |
| dashboard-nvim | Splash screen (hyper theme) |
| indent-blankline.nvim | Scope-aware indent guides |
| nvim-treesitter-context | Current function/class shown at top of window |
| barbecue.nvim | Breadcrumb winbar via nvim-navic |
| nvim-colorizer | Inline hex/rgb colour previews |
| vim-illuminate | Highlight all references to word under cursor |

### LSP & Completion
| Plugin | Role |
|--------|------|
| nvim-lspconfig | LSP server configs via `vim.lsp.config` (0.11 native) |
| mason.nvim | Auto-installs 20+ servers, formatters, linters |
| blink.cmp | Completion engine: LSP, snippets, buffer, path, emoji, git |
| LuaSnip + friendly-snippets | Snippet engine + thousands of snippets |
| conform.nvim | Format on save for every language |
| nvim-lint | Linting (selene, ruff, eslint, markdownlint, shellcheck) |
| trouble.nvim | Diagnostics panel, symbol list, LSP references |
| SchemaStore.nvim | JSON/YAML schema catalog |

### Language Tooling
| Plugin | Role |
|--------|------|
| nvim-treesitter | All grammars, textobjects, incremental selection |
| rustaceanvim | Full Rust IDE (clippy, macros, runnables, testables) |
| crates.nvim | Cargo.toml inline version management |
| typescript-tools.nvim | Native tsserver (faster than ts_ls) |
| go.nvim | Go tools (fill struct, if-err, generate, tags) |
| markdown-preview.nvim | Live browser preview |
| render-markdown.nvim | In-buffer markdown rendering |

### Navigation
| Plugin | Role |
|--------|------|
| telescope.nvim | Fuzzy finder + 7 extensions (fzf, frecency, undo, zoxide...) |
| harpoon2 | Pinned file hotkeys (`<leader>1-5`) |
| flash.nvim | Jump anywhere with `s`, treesitter select with `S` |
| outline.nvim | Symbol outline panel |
| project.nvim | Project root detection + switching |
| persistence.nvim | Session save/restore per directory |
| nvim-bqf | Enhanced quickfix window |
| todo-comments.nvim | TODO/FIXME/HACK highlights + navigation |

### Git
| Plugin | Role |
|--------|------|
| gitsigns.nvim | Hunk staging, inline blame, word diff, signcolumn |
| neogit | Magit-style full git client (opens in tab) |
| diffview.nvim | Full-screen diffs, file history, merge tool |
| octo.nvim | GitHub PRs, issues, reviews inside Neovim |

### Editor
| Plugin | Role |
|--------|------|
| nvim-surround | Add/change/delete surroundings (`ys`, `ds`, `cs`) |
| nvim-autopairs | Treesitter-aware bracket pairing |
| Comment.nvim | `gcc` line, `gbc` block, `gco`/`gcO`/`gcA` insert |
| treesj | Split/join blocks (`gS`/`gJ`/`gM`) |
| mini.ai | Extended text objects (`af`, `ac`, `aa`, `ab`...) |
| mini.move | Move lines/selections with `Alt+hjkl` |
| undotree | Visual undo history (`<leader>uu`) |
| zen-mode.nvim | Distraction-free mode (`<leader>uz`) |
| nvim-hlslens | Match count in virtual text |
| nvim-scrollbar | Scrollbar with git + search + diagnostic marks |
| neoscroll.nvim | Smooth scrolling |
| nvim-spectre | Project-wide find & replace (`<leader>sr`) |
| yanky.nvim | Yank history ring with sqlite + telescope |
| dial.nvim | Increment booleans, dates, hex, semver with `<C-a>` |
| vim-visual-multi | Multiple cursors (`<C-n>`) |

### Terminal & Tasks
| Plugin | Role |
|--------|------|
| toggleterm.nvim | Float/horizontal/vertical terminals, lazygit, btop |
| overseer.nvim | Task runner with toggleterm integration |
| neotest | Inline test runner (pytest, go, jest, vitest, rust) |

### AI
| Plugin | Role |
|--------|------|
| copilot.lua | Ghost-text completions via blink.cmp |
| avante.nvim | Cursor-style inline AI editing (Claude backend) |
| codecompanion.nvim | AI chat + slash commands + inline actions |

---

## Keymap Reference

> Leader key: `<Space>`

### Files & Search
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fr` | Recent files (frecency) |
| `<leader>fb` | Buffers |
| `<leader>fe` | File browser |
| `<leader>fp` | Projects |
| `<leader>fu` | Undo history |
| `<leader>f.` | Resume last picker |
| `<leader>/` | Fuzzy find in buffer |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `K` | Hover docs |
| `gK` | Signature help |
| `<leader>lr` | Rename symbol |
| `<leader>la` | Code action |
| `<leader>lf` | Format file |
| `<leader>lh` | Toggle inlay hints |
| `<leader>ld` | Line diagnostics |
| `<leader>lo` | Symbol outline |
| `[d` / `]d` | Prev/next diagnostic |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | Neogit |
| `<leader>gd` | Diff view |
| `<leader>gfh` | File history |
| `<leader>gb` | Blame line |
| `<leader>gtb` | Toggle line blame |
| `<leader>ghs` / `ghr` | Stage/reset hunk |
| `]h` / `[h` | Next/prev hunk |
| `ih` / `ah` | Hunk text object |

### Navigation
| Key | Action |
|-----|--------|
| `s` | Flash jump |
| `S` | Flash treesitter select |
| `<leader>ha` | Harpoon add file |
| `<leader>hh` | Harpoon menu |
| `<leader>1-5` | Harpoon jump to slot |
| `]f` / `[f` | Next/prev function |
| `]c` / `[c` | Next/prev class |
| `]]` / `[[` | Next/prev reference |

### Buffers & Splits
| Key | Action |
|-----|--------|
| `<S-h>` / `<S-l>` | Prev/next buffer |
| `[b` / `]b` | Prev/next buffer (bufferline) |
| `<C-hjkl>` | Navigate splits |
| `<leader>sv` / `sh` | Split vertical/horizontal |
| `<leader>bd` | Delete buffer |

### Terminal
| Key | Action |
|-----|--------|
| `<leader>tt` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tg` | Lazygit |
| `<leader>tm` | btop |
| `<C-\>` | Toggle float terminal |
| `<Esc><Esc>` | Exit terminal mode |

### AI
| Key | Action |
|-----|--------|
| `<leader>aa` | Avante ask |
| `<leader>ae` | Avante edit selection |
| `<leader>at` | Avante toggle |
| `<leader>ai` | CodeCompanion chat |
| `<leader>aI` | CodeCompanion actions |

### Editor
| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Surround add |
| `ds{char}` | Surround delete |
| `cs{char}{char}` | Surround change |
| `gcc` / `gbc` | Toggle line/block comment |
| `gS` / `gJ` | Split/join block |
| `<C-a>` / `<C-x>` | Increment/decrement (smart) |
| `<C-n>` | Multi-cursor on word |
| `<leader>sr` | Spectre project replace |
| `<leader>uu` | Undo tree |
| `<leader>uz` | Zen mode |

### Sessions
| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session (cwd) |
| `<leader>ql` | Restore last session |
| `<leader>qS` | Save session |

---

## Structure

```
~/.config/nvim/
├── init.lua                          # entry point
└── lua/bigboivim/
    ├── core/
    │   ├── options.lua               # ~60 vim options
    │   ├── keymaps.lua               # base keymaps
    │   └── autocmds.lua             # quality-of-life autocmds
    ├── lazy.lua                      # lazy.nvim bootstrap
    └── plugins/
        ├── init.lua                  # plugin manifest
        ├── ui/                       # statusline, bufferline, dashboard, noice...
        ├── lsp/                      # mason, lspconfig, blink.cmp, conform, trouble
        ├── lang/                     # treesitter, rust, typescript, go, markdown
        ├── telescope/                # telescope + extensions
        ├── navigation/               # harpoon, flash, outline, sessions, todo
        ├── git/                      # gitsigns, neogit, diffview, octo
        ├── editor/                   # surround, autopairs, spectre, yanky, dial...
        ├── terminal/                 # toggleterm, overseer, neotest
        └── ai/                       # copilot, avante, codecompanion
```

---

*Built on Arch Linux. Themed in Catppuccin Mocha. Powered by JetBrains Mono Nerd Font.*
