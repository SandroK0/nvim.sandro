function ColorMyPencils(color)
	color = color or "rose-pine"

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

return {
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
  },
  { 'Mofiqul/vscode.nvim' },
      {
        "rose-pine/neovim",
        name = "rose-pine",
    },
  {
    'LazyVim/LazyVim',
    priority = 10000,
    config = function()
      vim.cmd.colorscheme 'vscode'
    end,
  },
}
