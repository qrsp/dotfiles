vim.diagnostic.config({ virtual_text = { source = true } })
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = "MasonToolsUpdate",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          -- pip
          "sqlfluff",
          -- npm
          "prettierd",
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    cmd = "Conform",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          sql = { "sqlfluff" },
          javascript = { "prettierd" },
          json = { "prettierd" },
          jsonc = { "prettierd" },
          html = { "prettierd" },
          ["_"] = { "trim_whitespace" },
        },
      })
      vim.api.nvim_create_user_command("Conform", function()
        require("conform").format({ timeout_ms = 5000 })
      end, {})
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    dependencies = {
      "mason.nvim",
    },
    config = function()
      require("lint").linters_by_ft = {
        sql = { "sqlfluff" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })

      local sqlfluff = require("lint").linters.sqlfluff
      sqlfluff.args = {
        "lint",
        "--format=json",
        "--dialect=ansi",
        "-",
      }
      sqlfluff.stdin = true
    end,
  },
}
