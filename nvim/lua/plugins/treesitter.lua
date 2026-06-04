local languages = {
  "bash",
  "c",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "php",
  "python",
  "query",
  "regex",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
  "sql",
  "powershell",
  "xml",
}
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "VeryLazy" },
    build = ":TSUpdate",
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function ()
      vim.env.CC = 'gcc'
    end,
    opts = {
      ensure_installed = languages,
      fold = { enable = true },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-t>",
          node_incremental = "<C-t>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    cmd = { "TSContext" },
    config = function()
      require("treesitter-context").setup({
        enable = false,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  { "hiphish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },
}
