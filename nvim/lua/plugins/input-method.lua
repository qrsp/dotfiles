return {
  {
    "qrsp/imSelect.lua",
    cond = function() return jit.os == "Windows" end,
    event = "VeryLazy",
    config = function()
      require('imselect').setup({
        insert_engines = { 134481924 },
        normal_engines = { 67699721 },
      })
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
    end
  },
}
