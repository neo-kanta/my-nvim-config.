return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "neovim-treesitter/treesitter-parser-registry",
    },
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "bash",
        "css",
        "c_sharp",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "powershell",
        "regex",
        "scss",
        "sql",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "xml",
      }

      local treesitter = require("nvim-treesitter")
      local installed = treesitter.get_installed()
      local missing = vim.tbl_filter(function(parser)
        return not vim.tbl_contains(installed, parser)
      end, parsers)

      if #missing > 0 then
        treesitter.install(missing)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = { preset = "super-tab" },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
        },
        list = {
          selection = {
            preselect = function()
              return not require("blink.cmp").snippet_active({
                direction = 1,
              })
            end,
          },
        },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
  },
}
