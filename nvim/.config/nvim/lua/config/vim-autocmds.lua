return {
  setup = function()
    -- autocmds
    vim.api.nvim_create_autocmd("TextYankPost", {
      desc = "Higlight when yanking text",
      group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
      callback = function()
        vim.highlight.on_yank()
      end,
    })

    vim.api.nvim_create_autocmd("TermOpen", {
      desc = "Setting Configs for opened vim terminals",
      group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
      callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
      end,
    })

    local ts_available
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Start treesitter and auto-install missing parsers",
      group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang then
          return
        end
        if pcall(vim.treesitter.start, args.buf, lang) then
          return
        end
        if ts_available == nil then
          ts_available = require("nvim-treesitter").get_available()
        end
        if not vim.tbl_contains(ts_available, lang) then
          return
        end
        require("nvim-treesitter").install({ lang }):await(function(err)
          if err then
            return
          end
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(args.buf) then
              pcall(vim.treesitter.start, args.buf, lang)
            end
          end)
        end)
      end,
    })
  end,
}
