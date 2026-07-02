return {
  {
    "ibhagwan/fzf-lua",
    config = function()
      local actions = require("fzf-lua").actions
      require('fzf-lua').setup({
        "default-title",
        winopts = {
          width = 0.85,
          height = 0.95,
          preview = {
            hidden = true,
            vertical = "down:85%",
            layout = "vertical",
          },
        },
        keymap = {
          builtin = {
            true, -- uncomment to inherit all the below in your custom config
            ["?"]     = "toggle-help",
            ["<C-p>"] = "toggle-preview",
          },
        },
        actions = {
          files = {
            true, -- uncomment to inherit all the below in your custom config
            ["enter"] = actions.file_edit,
            ["alt-."] = actions.toggle_hidden,
            ["ctrl-t"] = require("trouble.sources.fzf").actions.open,
          },
        },
        defaults = {
          git_icons = false,
          file_icons = false,
        },
        fzf_opts = {
          ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-history',
        },
      })
      require("fzf-lua").register_ui_select()
    end,
    keys = {
      { "<leader><space>", function() require('fzf-lua').files() end,   desc = "Find Files" },
      { "<leader>R",       function() require('fzf-lua').resume() end,  desc = "Resume FzfLua" },
      { "<leader>f",       function() require('fzf-lua').builtin() end, desc = "FzfLua" },
      { "<leader>l",       function() require('fzf-lua').blines() end,  desc = "Find Lines" },
      { "<leader>/",       function() require("fzf-lua").grep() end,    desc = "FzfLua Grep" },
    },
  },
}
