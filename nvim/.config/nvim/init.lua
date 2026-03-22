require("config.lazy")

require("config.vim-keymaps").setup()
require("config.vim-options").setup()
require("config.vim-autocmds").setup()
require("config.vim-new-filetypes").setup()
-- require("config.godot").setup()
vim.cmd(":Copilot disable")

vim.cmd.colorscheme("catppuccin-mocha")
