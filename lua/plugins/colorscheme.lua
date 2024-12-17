return {
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
  },
  { 'Mofiqul/vscode.nvim' },
  {
    'LazyVim/LazyVim',
    priority = 10000,
    config = function()
      vim.cmd.colorscheme 'vscode'
    end,
  },
}
