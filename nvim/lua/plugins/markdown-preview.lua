return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    event = "VeryLazy",
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- Mandatory
      'nvim-tree/nvim-web-devicons',     -- Optional but recommended
    },
    config = function()
      require('render-markdown').setup({
        -- for markdown-pipetable.nvim
        pipe_table = { enabled = false },
        win_options = { concealcursor = { rendered = 'nvic' } },

        bullet = {
          ordered_icons = nil
        },
        checkbox = {
          checked = {rendered = '• ', scope_highlight = 'Conceal'},
          custom = {
            event = { raw = '[O]', rendered = '◯ '},
            task_in_progress = { raw = '[/]', rendered = '/ ', scope_highlight = 'Todo'},
            important_task = { raw = '[*]', rendered = '󰓎 ', highlight = 'WarningMsg'},
            task_cancelled = { raw = '[~]', rendered = '~ ', scope_highlight = '@markup.strikethrough'},
            task_migrated = { raw = '[>]', rendered = '> ', highlight = 'Error', scope_highlight = 'Error'},
            task_scheduled = { raw = '[<]', rendered = '< ', scope_highlight = 'Conceal'},
            note = { raw = '[-]', rendered = '- '},
            inspiration = { raw = '[!]', rendered = '! ', highlight = 'WarningMsg', scope_highlight = 'WarningMsg'},
            feeling = { raw = '[=]', rendered = '= ', highlight = nil, scope_highlight = nil},
            explore = { raw = '[?]', rendered = '? '},
            todo = { raw = '[󰥔]' }, -- delete default custom
          },
        },
      })
    end
  },
  {
    'dominic-righthere/markdown-pipetable.nvim',
    ft = 'markdown',
    config = function()
      require('pipetable').setup({})
    end,
  },
}
