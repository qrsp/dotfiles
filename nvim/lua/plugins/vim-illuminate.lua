-- Highlight symbol under cursor
return {
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    opts = {
      delay = 500,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = {
          "lsp",
          "treesitter",
        },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
}
