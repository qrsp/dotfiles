-- require
--   pip, npm(LSP)
--   gcc, tree-sitter(nvim-treesitter)
--   gcc, make(telescope-fzf-native.nvim)
--   ripgrep(telescope.nvim)
--   awk(trim_whitespace)

-- -- --
-- UI --
-- -- --
vim.o.cursorline = true
vim.o.sidescrolloff = 5
vim.o.scrolloff = 8
vim.o.number = true
vim.o.relativenumber = true
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.foldlevel = 10
vim.o.winborder = 'rounded'

vim.o.list = true
vim.o.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"

--- wrap indent
vim.o.breakindent = true
vim.o.showbreak = "↳"

--- search patterns
vim.o.ignorecase = true
vim.o.smartcase = true

--- edit
vim.o.inccommand = "split"    -- Preview substitute
vim.o.whichwrap = "h,l,<,>,~" -- Allow move to the previous/next line
vim.o.fileencodings = "utf-8,cp950,utf-16le,iso-2022-jp,euc-jp,sjis"

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.tabstop = 4

--- motion
vim.o.jumpoptions = "stack"

--- function
vim.o.mouse = "a"
vim.o.clipboard = "unnamed,unnamedplus" -- To ALWAYS use the clipboard for ALL operations

--- Provider
if jit.os == "Windows" then
  vim.g.python3_host_prog = "~/venvs/neovim/Scripts/python.exe"
end

-- --- --
-- Map --
-- --- --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n" }, "<Leader>w", "<Cmd>write<CR>")
vim.keymap.set({ "n" }, "<Leader>q", "<Cmd>quit<CR>")
vim.keymap.set({ "n" }, "Q", "<Cmd>qa<CR>")
vim.keymap.set({ "n" }, "<Leader>x", "<Cmd>xa<CR>")

vim.keymap.set({ "n" }, "<Leader>dd", "<Cmd>bdelete<CR>")
vim.keymap.set({ "n" }, "<Leader>zz", "<Cmd>xa!<CR>")
vim.keymap.set({ "n" }, "<Leader>zq", "<Cmd>qa!<CR>")

--- edit
vim.keymap.set({ "i" }, "jk", "<Esc>")
vim.keymap.set({ "i" }, "kj", "<Esc>")
vim.keymap.set({ "i" }, "<A-o>", "<C-o>o")
vim.keymap.set({ "i" }, "<A-O>", "<C-o>O")
-- Avoid inputting unintended characters on Windows by using glazeWM
vim.keymap.set({ "i" }, "<F20>", "<NOP>")

vim.keymap.set({ "v" }, "I", function()
  if vim.api.nvim_get_mode().mode == "V" then
    return "<C-v>^o^I"
  else
    return "I"
  end
end, { expr = true })
vim.keymap.set({ "v" }, "A", function()
  if vim.api.nvim_get_mode().mode == "V" then
    return "<C-v>0o$A"
  else
    return "A"
  end
end, { expr = true })

--- motion
vim.keymap.set({ "n" }, "<up>", "<c-u>")
vim.keymap.set({ "n" }, "<down>", "<c-d>")

--- windows
---- jump between windows
vim.keymap.set({ "n" }, "<A-h>", "<C-w>h")
vim.keymap.set({ "n" }, "<A-j>", "<C-w>j")
vim.keymap.set({ "n" }, "<A-k>", "<C-w>k")
vim.keymap.set({ "n" }, "<A-l>", "<C-w>l")
vim.keymap.set({ "i", "t" }, "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set({ "i", "t" }, "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set({ "i", "t" }, "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set({ "i", "t" }, "<A-l>", "<C-\\><C-N><C-w>l")

--- terminal
vim.keymap.set({ "t" }, "<Esc>", "<C-\\><C-n>")

---- move window to new tab
vim.keymap.set({ "n" }, "<A-t>", "<C-w>T")

-- ------- --
-- Autocmd --
-- ------- --
local indent_group = vim.api.nvim_create_augroup("Indent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.o.shiftwidth = 2
    vim.o.tabstop = 2
  end,
  group = indent_group,
  pattern = "lua",
})

--- run on save
vim.api.nvim_create_user_command("WatchRunToogle", function()
  local ok, err = pcall(function()
    local autocommands = vim.api.nvim_get_autocmds({
      group = "WatchRunToogle",
    })
  end)

  if ok then
    vim.api.nvim_del_augroup_by_name("WatchRunToogle")
    vim.notify("Delete WatchDog")
  else
    local group = vim.api.nvim_create_augroup("WatchRunToogle", { clear = false })
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("toggleterm").exec("uv run " .. vim.fn.expand("%:p"))
      end,
      group = group,
      pattern = "*.py"
    })
    vim.notify("Create WatchDog")
  end
end, {})

-- ---- --
-- Lazy --
-- ---- --

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- note
require("lazy").setup({
  change_detection = {
    enabled = false,
  },
  spec = "plugins",
})
