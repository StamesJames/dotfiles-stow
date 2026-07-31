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
    -- vim.opt.columns = 80

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

    -- textwidth
    -- vim.opt.textwidth = 80
    vim.opt.colorcolumn = { "81", "101" }

    vim.g.coqtail_noimap = true
    vim.cmd([[
      if &t_Co > 16
        if &background ==# 'dark'
          hi def CoqtailChecked ctermbg=17 guibg=#113311
          hi def CoqtailSent    ctermbg=60 guibg=#007630
        else
          hi def CoqtailChecked ctermbg=157 guibg=LightGreen
          hi def CoqtailSent    ctermbg=40  guibg=LimeGreen
        endif
      else
        hi def CoqtailChecked ctermbg=4 guibg=LightGreen
        hi def CoqtailSent    ctermbg=7 guibg=LimeGreen
      endif
      hi def link CoqtailError         Error
      hi def link CoqtailOmitted       coqProofAdmit
    ]])
  end,
}
