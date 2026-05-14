-- BigBoiVim -- autocmds.lua


local function augroup(name)
  return vim.api.nvim_create_augroup("bigboivim_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- ── Highlight on yank ────────────────────────────────────────────────────────
autocmd("TextYankPost", {
  group = augroup("yank_highlight"),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

-- ── Restore cursor position on file open ────────────────────────────────────
autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function(event)
    local exclude = { "gitcommit", "gitrebase" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then return end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local line_count = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ── Auto-resize splits when window is resized ────────────────────────────────
autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- ── Remove trailing whitespace on save ───────────────────────────────────────
autocmd("BufWritePre", {
  group = augroup("trim_whitespace"),
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- ── Close certain buffers with just 'q' ─────────────────────────────────────
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "help", "man", "qf", "notify", "nofile",
    "lspinfo", "checkhealth", "startuptime",
    "fugitive", "git", "DiffviewFiles",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- ── Auto-create directories on save ─────────────────────────────────────────
autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- ── Filetype-specific settings ───────────────────────────────────────────────
autocmd("FileType", {
  group = augroup("filetype_settings"),
  pattern = { "markdown", "text", "rst" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

autocmd("FileType", {
  group = augroup("filetype_4space"),
  pattern = { "python", "rust", "go", "c", "cpp", "java" },
  callback = function()
    vim.opt_local.tabstop     = 4
    vim.opt_local.shiftwidth  = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- ── Check for file changes when focusing window ──────────────────────────────
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- ── Disable auto-comment on newline ─────────────────────────────────────────
autocmd("BufEnter", {
  group = augroup("no_auto_comment"),
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- ── Terminal quality of life ──────────────────────────────────────────────────
autocmd("TermOpen", {
  group = augroup("terminal_settings"),
  callback = function()
    vim.opt_local.number         = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn     = "no"
    vim.cmd("startinsert")
  end,
})
