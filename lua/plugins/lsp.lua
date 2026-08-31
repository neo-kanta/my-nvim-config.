return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    config = function()
      vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        signs = true,
        virtual_text = {
          spacing = 2,
          source = "if_many",
        },
        float = {
          border = "rounded",
          source = true,
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, {
              buffer = args.buf,
              silent = true,
              desc = desc,
            })
          end

          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
          map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, "Previous diagnostic")
          map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, "Next diagnostic")
        end,
      })

      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      local vue_server_path = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

      vim.lsp.config("vtsls", {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
        },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_server_path,
                  languages = { "vue" },
                  configNamespace = "typescript",
                },
              },
            },
          },
        },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim", "Snacks" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },
      })

      local eslint_on_attach = vim.lsp.config.eslint.on_attach
      vim.lsp.config("eslint", {
        settings = {
          format = false,
        },
        on_attach = function(client, bufnr)
          if eslint_on_attach then
            eslint_on_attach(client, bufnr)
          end
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "vue_ls",
          "vtsls",
          "eslint",
          "roslyn_ls",
          "lua_ls",
          "jsonls",
          "html",
          "cssls",
        },
        automatic_enable = {
          "vue_ls",
          "vtsls",
          "eslint",
          "roslyn_ls",
          "lua_ls",
          "jsonls",
          "html",
          "cssls",
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true })
        end,
        mode = { "n", "x" },
        desc = "Format",
      },
      {
        "<leader>cF",
        function()
          if vim.fn.exists(":LspEslintFixAll") == 2 then
            vim.cmd.LspEslintFixAll()
          else
            vim.notify("ESLint is not attached", vim.log.levels.WARN)
          end
        end,
        desc = "ESLint fix all",
      },
    },
    opts = {
      formatters_by_ft = {
        vue = { "prettier", lsp_format = "never" },
        javascript = { "prettier", lsp_format = "never" },
        javascriptreact = { "prettier", lsp_format = "never" },
        typescript = { "prettier", lsp_format = "never" },
        typescriptreact = { "prettier", lsp_format = "never" },
        html = { "prettier", lsp_format = "never" },
        css = { "prettier", lsp_format = "never" },
        scss = { "prettier", lsp_format = "never" },
        json = { "prettier", lsp_format = "never" },
        jsonc = { "prettier", lsp_format = "never" },
        markdown = { "prettier", lsp_format = "never" },
        cs = { lsp_format = "prefer" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        timeout_ms = 1500,
      },
    },
  },
}
