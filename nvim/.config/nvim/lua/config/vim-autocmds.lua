return {
  setup = function()
    -- autocmds
    vim.api.nvim_create_autocmd('TextYankPost', {
      desc = 'Higlight when yanking text',
      group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
      callback = function()
        vim.highlight.on_yank()
      end,
    })
  end
}
