return {
  setup = function()
    -- tap
    vim.opt.expandtab = true
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2

    -- line numbering
    vim.opt.number = true
    vim.opt.relativenumber = true

    -- whitespace
    vim.opt.list = true
    vim.opt.listchars = {
      multispace = "·",
      lead = " ",
      tab = "> ",
      trail = "·",
      nbsp = "+",
    }
    -- clipboard things
    vim.opt.clipboard = "unnamedplus"

    -- line wraping
    vim.opt.breakindent = true
    vim.opt.linebreak = true
    vim.opt.smoothscroll = true
    vim.opt.showbreak = "> "
  end,
}
