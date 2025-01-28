vim.hl = vim.highlight
vim.g.mapleader = " "
print("Hello from init.lua")

require("config.vim-keymaps").setup()
require("config.vim-options").setup()
require("config.vim-autocmds").setup()

require("config.lazy")
