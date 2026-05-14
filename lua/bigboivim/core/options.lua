-- BigBoiVim -- options.lua


local opt = vim.opt

-- ── UI ─────────────────────────────────────────────────────────────────────
opt.number         = true          -- line numbers
opt.relativenumber = true          -- relative line numbers
opt.signcolumn     = "yes:2"       -- always show, 2 wide (room for git + diagnostics)
opt.cursorline     = true          -- highlight current line
opt.termguicolors  = true          -- true color support
opt.showmode       = false         -- mode shown in statusline instead
opt.pumheight      = 10            -- max completion menu items
opt.pumblend       = 10            -- slight transparency on popup menu
opt.winblend       = 10            -- slight transparency on floating windows
opt.scrolloff      = 8             -- keep 8 lines above/below cursor
opt.sidescrolloff  = 8             -- keep 8 cols left/right of cursor
opt.wrap           = false         -- no line wrapping
opt.linebreak      = true          -- if wrap is on, break at word boundary
opt.colorcolumn    = "100"         -- ruler at 100 chars
opt.conceallevel   = 2             -- hide markup in markdown/org
opt.cmdheight      = 1             -- command line height (noice will take over)
opt.laststatus     = 3             -- global statusline (single bar for all splits)
opt.list           = true          -- show invisible characters
opt.listchars      = {
  tab      = "→ ",
  trail    = "·",
  nbsp     = "␣",
  extends  = "▶",
  precedes = "◀",
}
opt.fillchars      = {
  foldopen  = "▾",
  foldclose = "▸",
  fold      = " ",
  foldsep   = " ",
  diff      = "╱",
  eob       = " ",               -- hide ~ at end of buffer
}

-- ── Editing ─────────────────────────────────────────────────────────────────
opt.expandtab   = true            -- spaces not tabs
opt.tabstop     = 2               -- 2-space tabs
opt.shiftwidth  = 2               -- indent size
opt.softtabstop = 2
opt.smartindent = true            -- auto-indent on new lines
opt.shiftround  = true            -- round indent to shiftwidth

opt.clipboard   = "unnamedplus"   -- system clipboard by default
opt.mouse       = "a"             -- mouse in all modes

opt.virtualedit = "block"         -- allow cursor past end of line in visual block

-- ── Search ──────────────────────────────────────────────────────────────────
opt.ignorecase = true             -- case-insensitive search...
opt.smartcase  = true             -- ...unless query has uppercase
opt.hlsearch   = true             -- highlight search results
opt.incsearch  = true             -- show matches as you type
opt.grepprg    = "rg --vimgrep"  -- use ripgrep for :grep
opt.grepformat = "%f:%l:%c:%m"

-- ── Splits ──────────────────────────────────────────────────────────────────
opt.splitbelow = true             -- horizontal splits go below
opt.splitright = true             -- vertical splits go right
opt.splitkeep = "screen"          -- keep split sizes on layout change (nvim 0.9+)

-- ── Folds ───────────────────────────────────────────────────────────────────
opt.foldmethod    = "expr"
opt.foldexpr      = "nvim_treesitter#foldexpr()" -- treesitter-aware folds
opt.foldlevel     = 99            -- start with all folds open
opt.foldlevelstart = 99
opt.foldenable    = true

-- ── Performance ─────────────────────────────────────────────────────────────
opt.updatetime  = 200             -- faster CursorHold (default 4000ms)
opt.timeoutlen  = 300             -- faster which-key trigger (ms)
opt.lazyredraw  = false           -- don't skip redraws (causes issues with noice)
opt.redrawtime  = 1500            -- stop highlighting if it takes too long

-- ── Files ───────────────────────────────────────────────────────────────────
opt.undofile   = true             -- persistent undo across sessions
opt.undolevels = 10000            -- deep undo history
opt.backup     = false            -- no backup files (we have git)
opt.swapfile   = false            -- no swap files

opt.autoread   = true             -- reload file if changed outside nvim
opt.confirm    = true             -- ask instead of failing on unsaved changes

-- ── Completion ──────────────────────────────────────────────────────────────
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("cC")        -- suppress completion messages

-- ── Spelling ────────────────────────────────────────────────────────────────
opt.spelllang = "en_us"
opt.spelloptions = "camel"        -- spell-check camelCase words separately

-- ── Misc ────────────────────────────────────────────────────────────────────
opt.sessionoptions = "buffers,curdir,folds,globals,help,tabpages,terminal,winsize"
opt.diffopt:append("linematch:60") -- better diff alignment

-- Neovim 0.10+ native features
if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true         -- smooth scrolling with <C-d>/<C-u>
end
