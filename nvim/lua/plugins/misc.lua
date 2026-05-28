return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },
  {
    'sQVe/sort.nvim',
    cmd = "Sort",
    config = function()
      require('sort').setup({
        mappings = {
          operator = false,
          textobject = false,
          motion = false,
        },
      })
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
        end,
      })
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    config = function()
      require("grug-far").setup({
        normalModeSearch = true,
        transient = true,
        prefills = {
          paths = vim.fn.expand("%"),
          flags = "--ignore-case",
        },
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    'nvim-mini/mini.align',
    event = "VeryLazy",
    version = '*',
    config = function()
      require('mini.align').setup({
        options = {
          split_pattern = '|',
          justify_side = 'center',
          merge_delimiter = '',
        },
      })
    end
  },
  {
    "gennaro-tedesco/nvim-jqx",
    cmd = "JqxList",
    ft = { "json", "yaml" },
  },
  {
    "nvim-mini/mini.trailspace",
    cmd = "Trailspace",
    version = "*",
    config = function()
      require("mini.trailspace").setup()
      vim.api.nvim_create_user_command("Trailspace", function()
        MiniTrailspace.trim()
      end, {})
    end,
  },
  { "jghauser/follow-md-links.nvim", event = "VeryLazy", },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },
  { "tpope/vim-unimpaired",          event = "VeryLazy", },
  { "nvim-tree/nvim-web-devicons",   event = "VeryLazy", },
  { "farmergreg/vim-lastplace" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  -- Disable highlight automatic
  { "romainl/vim-cool", event = "VeryLazy", },
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<F1>", "<Cmd>ZenMode<CR>" },
    },
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.75,
          width = 100
        }
      })
    end
  },
}
