return {
  {
    "goolord/alpha-nvim",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      -- Set header
      dashboard.section.header.val = {}
      dashboard.section.buttons.val = {
        dashboard.button("e", " > New File", "<cmd>ene<CR>"),
        dashboard.button("f", "󰱼 > Find Files", function() require('fzf-lua').files() end),
        dashboard.button("g", "󰷾 > Grep Text", function() require("fzf-lua").grep() end),
        dashboard.button("r", " > Find Recent Files", function() require("fzf-lua").oldfiles() end),
        dashboard.button("s", " > Load Session", function() require("nvim-possession").list() end),
        dashboard.button("q", " > Quit NVIM", "<cmd>q<CR>"),
      }
      alpha.setup(dashboard.opts)
    end,
  },
}
