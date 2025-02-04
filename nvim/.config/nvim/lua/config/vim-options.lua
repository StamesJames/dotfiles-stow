return {
  setup = function()
    -- opts
    vim.opt.expandtab = true
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2

    vim.opt.number = true
    vim.opt.relativenumber = true

    vim.opt.clipboard = "unnamedplus"

    vim.opt.columns = 80
    vim.opt.colorcolumn = { 75 }
    vim.opt.breakindent = true
    vim.opt.linebreak = true
    vim.opt.smoothscroll = true
    vim.opt.showbreak = "> "
  end,
}
