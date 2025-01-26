return {
  setup = function()
    -- keymaps
    vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
    vim.keymap.set("n", "<leader>x", ":.lua<CR>")
    vim.keymap.set("v", "<leader>x", ":lua<CR>")
    -- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- disabled for neo-tree
  end,
}
