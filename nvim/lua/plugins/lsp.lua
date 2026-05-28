-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- vim.diagnostic.enable(false)
vim.keymap.set("n", "<leader>dx", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { noremap = true, silent = true, desc = "Toggle vim diagnostics" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.api.nvim_buf_create_user_command(0, "Format", function()
      vim.lsp.buf.format({ async = true })
    end, {})

    -- inlay-hints: https://github.com/MysticalDevil/inlay-hints.nvim
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "mason.nvim",
    },
    config = function()
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("ruff")
      vim.lsp.config("ruff", {
        capabilities = {
          general = {
            positionEncodings = { "utf-16" },
          },
        },
      })

      vim.lsp.enable("lua_ls")
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      })


      -- PHP --
      -- Need .git or composer.json to find root_dir
      vim.lsp.enable("intelephense")

      -- After run `composer init`
      -- `~/AppData/Local/nvim-data/mason/bin/psalm.cmd --init` to create psalm.xml
      -- `~/.local/share/nvim/mason/bin/psalm --init`
      -- Need to install `php` and `php-xml` on debian
      vim.lsp.enable("psalm")

      -- Markdown --
      vim.lsp.config("rumdl", {
        cmd = { "rumdl", "server", "--config", vim.fn.stdpath("config") .. "/.rumdl.toml" },
      })
      vim.lsp.enable("rumdl")

      vim.lsp.enable({"mpls"})

    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    cmd = "LspInstall",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = false,
      ensure_installed = {
        "lua_ls",
        "rumdl",
        "mpls",
        -- pip
        "ruff",
        "basedpyright",
        -- npm
        "intelephense",
        -- php php-xml
        "psalm",
      },
    },
  },
  {
    "hedyhli/outline.nvim",
    keys = {
      { "<F3>", "<Cmd>Outline<CR>", "Toggle Outline" },
    },
    config = function()
      require("outline").setup({
        outline_items = {
          show_symbol_lineno = true,
          show_symbol_details = false,
        },
        outline_window = {
          show_cursorline = true,
          hide_cursor = true,
        },
      })
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
    end
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = { use_diagnostic_signs = true },
  },
}
