local function open_project_folder()
  Snacks.picker.projects({
    dev = { "C:/Users/kanta/source/repos" },
    confirm = { "tcd", "picker_explorer" },
  })
end

local function find_hidden_files()
  Snacks.picker.files({
    hidden = true,
    ignored = true,
    exclude = { ".git", "node_modules", "dist", "bin", "obj" },
  })
end

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "o", desc = "Open Folder", action = open_project_folder },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "h", desc = "Find Hidden File", action = find_hidden_files },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      explorer = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            -- Keep search results when focus moves back to the editor.
            follow_file = false,
            hidden = true,
            ignored = true,
            exclude = { ".git", "node_modules", "dist", "bin", "obj" },
          },
        },
      },
      quickfile = { enabled = true },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find files",
      },
      {
        "<leader>fH",
        find_hidden_files,
        desc = "Find hidden/ignored files",
      },
      {
        "<leader>fp",
        open_project_folder,
        desc = "Open folder/project",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Find text",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent files",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete buffer",
      },
      {
        "<leader>tt",
        function()
          Snacks.terminal()
        end,
        mode = { "n", "t" },
        desc = "Toggle terminal",
      },
      {
        "<C-/>",
        function()
          Snacks.terminal()
        end,
        mode = { "n", "t" },
        desc = "Toggle terminal",
      },
      {
        "<C-_>",
        function()
          Snacks.terminal()
        end,
        mode = { "n", "t" },
        desc = "Toggle terminal",
      },
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Definition",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
          always_show_tabline = false,
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "diagnostics", "lsp_status", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        tabline = {
          lualine_a = {
            {
              "buffers",
              show_filename_only = true,
              show_modified_status = true,
              use_mode_colors = false,
              symbols = {
                modified = " ●",
                alternate_file = "",
                directory = "",
              },
            },
          },
        },
      })

      local function update_tabline()
        local count = 0
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
            count = count + 1
          end
        end
        vim.o.showtabline = count > 1 and 2 or 0
      end

      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "BufEnter" }, {
        callback = function()
          vim.schedule(update_tabline)
        end,
      })
      update_tabline()
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>b", group = "buffers" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>s", group = "splits" },
        { "<leader>t", group = "terminal" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer keymaps",
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, {
            buffer = bufnr,
            silent = true,
            desc = desc,
          })
        end

        map("]h", function()
          gs.nav_hunk("next")
        end, "Next Git hunk")
        map("[h", function()
          gs.nav_hunk("prev")
        end, "Previous Git hunk")
        map("<leader>gp", gs.preview_hunk, "Preview hunk")
        map("<leader>gs", gs.stage_hunk, "Stage hunk")
        map("<leader>gr", gs.reset_hunk, "Reset hunk")
      end,
    },
  },
}
