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
    vim.opt.signcolumn = "yes"

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
    vim.opt.columns = 80

    -- searching
    vim.opt.hlsearch = false
    vim.opt.incsearch = true

    -- backup and undo
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    vim.opt.undofile = true

    -- colors
    vim.opt.termguicolors = true

    -- scrolling
    vim.opt.scrolloff = 8
  end,
}
