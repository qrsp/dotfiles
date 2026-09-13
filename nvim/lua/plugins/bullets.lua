local bullet_group = vim.api.nvim_create_augroup("BulletsMap", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    -- automatic bullets
    vim.keymap.set({ "n" }, "o", "<Plug>(bullets-newline)")
    vim.keymap.set({ "i" }, "<a-o>", "<Esc><Plug>(bullets-newline)")

    -- promote and demote outline level
    vim.keymap.set({ "i" }, "<C-t>", "<Plug>(bullets-demote)")
    vim.keymap.set({ "n" }, ">>", "<Plug>(bullets-demote)")
    vim.keymap.set({ "v" }, ">", "<Plug>(bullets-demote)")
    vim.keymap.set({ "i" }, "<C-d>", "<Plug>(bullets-promote)")
    vim.keymap.set({ "n" }, "<<", "<Plug>(bullets-promote)")
    vim.keymap.set({ "v" }, "<", "<Plug>(bullets-promote)")
  end,
  group = bullet_group,
  pattern = "markdown",
})

return {
  {
    "dkarter/bullets.vim",
    event = "VeryLazy",
    config = function()
      vim.g.bullets_set_mappings = 0
      vim.g.bullets_outline_levels = { "std-" }
    end,
  },
}
