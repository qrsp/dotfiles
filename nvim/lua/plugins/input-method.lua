return {
  {
    "qrsp/imSelect.lua",
    cond = function() return jit.os == "Windows" end,
    event = "VeryLazy",
    config = function()
      require('imselect').setup({
        insert_engines = { 67372036 },
        normal_engines = { 67699721 },
      })
      vim.g.input_method = require('imselect')
    end,
  },
  {
    "qrsp/ibus.lua",
    cond = function() return jit.os == "Linux" end,
    event = "VeryLazy",
    config = function()
      require('ibus').setup({
        insert_engines = { 'rime', 'mozc-jp' },
        normal_engines = { 'xkb:us::eng' },
        no_mappings = false
      })
      vim.g.input_method = require('ibus')
    end
  },
  {
    "kkew3/jieba.vim",
    tag = "v2.1.1",
    build = ":call jieba_vim#install()",
    init = function()
      vim.g.jieba_vim_lazy = 1
      vim.g.jieba_vim_keymap = 1
    end,
  },
}
