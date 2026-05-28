return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<F7>" },
    },
    config = function()
      if jit.os == "Windows" then
        local powershell_options = {
          shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
          shellcmdflag =
          "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
          shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
          shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
          shellquote = "",
          shellxquote = "",
        }

        for option, value in pairs(powershell_options) do
          vim.opt[option] = value
        end
      end

      require("toggleterm").setup({
        -- size can be a number or function which is passed the current terminal
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        on_create = function()
          vim.opt.foldcolumn = "0"
          vim.opt.signcolumn = "no"
        end,
        open_mapping = [[<F7>]],
        shading_factor = 2,
        direction = "vertical",
      })

      local trim_spaces = false
      vim.keymap.set("v", "<leader>t", function()
        require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
      end)
    end,
  },
}
