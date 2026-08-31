local group = vim.api.nvim_create_augroup("pam_user_config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  desc = "Highlight copied text",
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "help", "man", "qf", "checkhealth" },
  desc = "Close utility buffers with q",
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = args.buf,
      silent = true,
      desc = "Close window",
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "markdown", "text" },
  desc = "Wrap prose without changing code defaults",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})
