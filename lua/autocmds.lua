-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
    clear = true,
  }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set Go-specific settings for tab width
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go', -- For Go files
  callback = function()
    vim.bo.tabstop = 4 -- Set the number of spaces that a tab counts for
    vim.bo.shiftwidth = 4 -- Set the number of spaces to use for each step of (auto)indent
    vim.bo.softtabstop = 4 -- Set the number of spaces that a <Tab> key inserts
    vim.bo.expandtab = true -- Use spaces instead of tabs
  end,
})
