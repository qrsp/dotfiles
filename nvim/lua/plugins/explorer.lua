return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
        delete_to_trash = true,

        -- oil-git-status
        win_options = {
          signcolumn = "yes:2",
        },
      })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
  {
    "refractalize/oil-git-status.nvim",
    event = "VeryLazy",
    dependencies = {
      "stevearc/oil.nvim",
    },
    config = true,
  },
  {
    "nvim-tree/nvim-tree.lua",
    keys = { "<F2>" },
    config = function()
      require("nvim-tree").setup({
        view = {
          number = true,
          relativenumber = true,
        },
        ui = {
          confirm = {
            trash = false,
          },
        },
      })
      vim.keymap.set("n", "<F2>", "<CMD>NvimTreeToggle<CR>", { desc = "Open parent directory" })
    end,
  },
}
