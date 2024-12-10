return {
  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup {
        styles = {
          italic = false,
        },
        highlight_groups = {
          Normal = {
            bg = '#000000',
          },
          NormalFloat = {
            bg = '#000000',
          },
          NormalNC = {
            bg = '#000000',
          },
          SignColumn = {
            bg = '#000000',
          },
          EndOfBuffer = {
            bg = '#000000',
          },
        },
      }
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
  },
  { 'Mofiqul/vscode.nvim' },
  {
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    lazy = false,
    priority = 1000,
  },
  { 'navarasu/onedark.nvim' },
  { 'aliqyan-21/darkvoid.nvim' },
  { 'folke/tokyonight.nvim' },
  { 'rebelot/kanagawa.nvim' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'LazyVim/LazyVim',
    priority = 10000,
    config = function()
      vim.cmd.colorscheme 'carbonfox'
    end,
  },
}

