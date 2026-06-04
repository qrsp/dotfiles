local colorscheme = {
  {
    "folke/tokyonight.nvim",
    cond = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        on_colors = function(colors)
          colors.comment = "#888fac"
        end,
        on_highlights = function(hl, c)
          hl["@markup.strong"] = {
            fg = c.warning,
          }
        end,
      })
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    "catppuccin/nvim",
    cond = false,
    name = "catppuccin",
    init = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        highlight_overrides = {
          macchiato = function(macchiato)
            return {
              ["@comment"] = { fg = macchiato.overlay0, style = { "italic" } },
              ["@markup.link.label.markdown_inline"] = { fg = macchiato.green },
              ["@markup.link.url.markdown_inline"] = {
                fg = macchiato.blue,
                style = { "italic", "underline" },
              },
            }
          end,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "sainnhe/sonokai",
    cond = false,
    config = function()
      local styless = { 'default', 'atlantis', 'andromeda', 'maia' }
      vim.g.sonokai_style = styless[math.random(5)]
      vim.g.sonokai_better_performance = 1
      vim.cmd.colorscheme("sonokai")
      vim.api.nvim_set_hl(0, 'TSStrong', { link = 'orange' })
    end
  },
  {
    "marekh19/meowsoot.nvim",
    cond = false,
    config = function()
      vim.cmd.colorscheme("meowsoot")
    end,
  }
}

math.randomseed(vim.loop.now())
colorscheme[math.random(#colorscheme)]["cond"] = true
return colorscheme
