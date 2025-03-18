-- Basic setup
vim.cmd('syntax on')
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.autoread = true
vim.opt.laststatus = 2  -- Always show status line

-- Indentation configuration
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = true

-- Filetype-specific indentation
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'javascript', 'typescript', 'html', 'scss', 'tsx'},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.opt_local.expandtab = false
  end
})

-- File search configuration
vim.opt.path:append('**')  -- Recursive file search
vim.opt.wildmenu = true    -- Show interactive menu

-- Ignore patterns
vim.opt.wildignore:append({
  '**/vendor/**',    -- PHP Composer
  '**/tags',         -- ctags
  '**/node_modules/**',
  '**/react/**'      -- Flathat submodule
})
