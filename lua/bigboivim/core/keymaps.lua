-- BigBoiVim — keymaps.lua

local map = vim.keymap.set

-- ── Better defaults ──────────────────────────────────────────────────────────

-- Keep cursor centered on search navigation
map("n", "n", "nzzzv", { desc = "Next match (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev match (centered)" })

-- Keep cursor centered on half-page jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Don't lose selection when indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines up/down (like VS Code Alt+up/down)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("n", "<A-j>", ":m .+1<CR>==",     { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==",     { desc = "Move line up" })

-- Paste without overwriting register in visual mode
map("v", "p", '"_dP', { desc = "Paste without yanking selection" })

-- Delete without overwriting register
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Yank to end of line (consistent with D and C)
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Don't move cursor when joining lines
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Better up/down on wrapped lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search highlight on Escape
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })

-- ── Splits ───────────────────────────────────────────────────────────────────
map("n", "<leader>sv", "<C-w>v",         { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s",         { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=",         { desc = "Equal split sizes" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- Navigate splits with CTRL+hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Resize splits with CTRL+arrows
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Increase height" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Decrease height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })

-- ── Tabs ─────────────────────────────────────────────────────────────────────
map("n", "<leader><tab>n", "<cmd>tabnew<CR>",      { desc = "New tab" })
map("n", "<leader><tab>x", "<cmd>tabclose<CR>",    { desc = "Close tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<CR>",     { desc = "Next tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Prev tab" })

-- ── Buffers ──────────────────────────────────────────────────────────────────
map("n", "<S-h>",      "<cmd>bprevious<CR>",                       { desc = "Prev buffer" })
map("n", "<S-l>",      "<cmd>bnext<CR>",                           { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>",                         { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<CR>",                        { desc = "Force delete buffer" })
map("n", "<leader>bo", "<cmd>%bdelete|edit#|bdelete#<CR>",         { desc = "Close all other buffers" })

-- ── File ─────────────────────────────────────────────────────────────────────
map("n", "<leader>w",  "<cmd>w<CR>",   { desc = "Save" })
map("n", "<leader>W",  "<cmd>wa<CR>",  { desc = "Save all" })
map("n", "<leader>q",  "<cmd>q<CR>",   { desc = "Quit" })
map("n", "<leader>Q",  "<cmd>qa!<CR>", { desc = "Quit all (force)" })

-- ── LSP (placeholders — plugins will override these) ─────────────────────────
map("n", "<leader>l",  "", { desc = "+lsp" })
map("n", "<leader>ld", "", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>lf", "", { desc = "Format file" })
map("n", "<leader>lr", "", { desc = "Rename symbol" })
map("n", "<leader>la", "", { desc = "Code action" })

-- ── Git (placeholders) ───────────────────────────────────────────────────────
map("n", "<leader>g",  "", { desc = "+git" })
map("n", "<leader>gg", "", { desc = "Open Neogit" })
map("n", "<leader>gd", "", { desc = "Diff view" })
map("n", "<leader>gb", "", { desc = "Git blame line" })
map("n", "<leader>gB", "", { desc = "Git blame buffer" })

-- ── Search (placeholders) ────────────────────────────────────────────────────
map("n", "<leader>f",  "", { desc = "+find" })
map("n", "<leader>ff", "", { desc = "Find files" })
map("n", "<leader>fg", "", { desc = "Live grep" })
map("n", "<leader>fb", "", { desc = "Buffers" })
map("n", "<leader>fr", "", { desc = "Recent files" })
map("n", "<leader>fk", "", { desc = "Keymaps" })

-- ── Terminal (placeholders) ──────────────────────────────────────────────────
map("n", "<leader>t",  "", { desc = "+terminal/test" })
map("n", "<leader>tt", "", { desc = "Toggle terminal" })
map("n", "<leader>tg", "", { desc = "Lazygit" })

-- ── UI toggles ───────────────────────────────────────────────────────────────
map("n", "<leader>u",  "", { desc = "+ui" })
map("n", "<leader>uw", function() vim.opt.wrap = not vim.opt.wrap:get() end,           { desc = "Toggle wrap" })
map("n", "<leader>us", function() vim.opt.spell = not vim.opt.spell:get() end,         { desc = "Toggle spell" })
map("n", "<leader>ul", function() vim.opt.relativenumber = not vim.opt.relativenumber:get() end, { desc = "Toggle relative numbers" })

-- ── Misc ─────────────────────────────────────────────────────────────────────
map("n", "<leader>ui", vim.show_pos,    { desc = "Inspect highlight at cursor" })
map("n", "<C-a>",      "ggVG",          { desc = "Select all" })
map("n", "<leader>L",  "<cmd>Lazy<CR>", { desc = "Open Lazy" })
map("n", "<leader>M",  "<cmd>Mason<CR>",{ desc = "Open Mason" })
