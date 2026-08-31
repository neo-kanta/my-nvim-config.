local map = vim.keymap.set
local opts = { silent = true }

map("n", "<Esc>", "<cmd>nohlsearch<cr>", {
  silent = true,
  desc = "Clear search highlight",
})
map("n", "<C-s>", "<cmd>write<cr>", {
  silent = true,
  desc = "Save file",
})

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<leader>sh", "<cmd>split<cr>", {
  silent = true,
  desc = "Horizontal split",
})
map("n", "<leader>sv", "<cmd>vsplit<cr>", {
  silent = true,
  desc = "Vertical split",
})

map("n", "[b", "<cmd>bprevious<cr>", {
  silent = true,
  desc = "Previous buffer",
})
map("n", "]b", "<cmd>bnext<cr>", {
  silent = true,
  desc = "Next buffer",
})

map("t", "<Esc><Esc>", "<C-\\><C-n>", {
  silent = true,
  desc = "Leave terminal input mode",
})
