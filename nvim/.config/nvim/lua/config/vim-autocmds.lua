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

    -- Start treesitter on file open and install with nvim-treesitter if not installed
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "*" },
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if vim.g.ts_available then
          vim.treesitter.start(args.buf, lang)
        end

        -- if not vim.treesitter.language.add(lang) then
        --   -- this stupid tracking is here only because
        --   -- they have added warnings on absent parsers
        --   local available = vim.g.ts_available or require("nvim-treesitter").get_available()
        --   if not vim.g.ts_available then
        --     vim.g.ts_available = available
        --   end
        --   if vim.tbl_contains(available, lang) then
        --     require("nvim-treesitter").install(lang)
        --   end
        -- end
        --
        -- if vim.treesitter.language.add(lang) then
        --   vim.treesitter.start(args.buf, lang)
        --   -- this is an experimental feature
        --   -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        --   -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        --   -- vim.wo[0][0].foldmethod = "expr"
        -- end
      end,
    })
  end,
}
