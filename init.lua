vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
vim.filetype.add({
  extension = {
    xaml = "xml",
  },
})
vim.cmd.colorscheme("vs-dark")
require("config.autocmds")
require("config.keymaps")
require("config.lazy")
