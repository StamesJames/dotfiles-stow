return {
  setup = function()
    -- moving through wraped lines
    vim.keymap.set({ "n", "v" }, "j", "gj", { noremap = true })
    vim.keymap.set({ "n", "v" }, "k", "gk", { noremap = true })

    -- terminal stuff
    vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

    -- keymaps
    vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
    vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
    vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
    vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

    -- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- deactivated for oil

    -- move lines
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

    -- scrolling
    vim.keymap.set("n", "<C-d>", "<C-d>zz")
    vim.keymap.set("n", "<C-u>", "<C-u>zz")

    -- pasteing and deleting
    vim.keymap.set("x", "<leader>p", '"_dP')
    vim.keymap.set("n", "<leader>d", '"_dP')
    vim.keymap.set("v", "<leader>d", '"_dP')

    -- trim trailing whitespace
    vim.keymap.set("n", "<leader>ww", ":%s/  *$//g<CR>")
  end,
}
