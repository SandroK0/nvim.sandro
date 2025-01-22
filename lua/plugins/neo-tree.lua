return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- recommended for file icons
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'Toggle NeoTree', silent = true },
  },
  opts = {
    close_if_last_window = true, -- Close NeoTree if it's the last window open
    popup_border_style = 'rounded', -- Rounded borders for a modern look
    enable_git_status = false, -- Disable git status column for minimalism
    enable_diagnostics = false, -- Disable diagnostic symbols for a cleaner look
    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1, -- Padding for better alignment
        with_markers = false, -- Remove indent markers for a flat look
      },
      icon = {
        folder_closed = '', -- Minimal VS Code-style folder icon
        folder_open = '',
        folder_empty = '',
        default = '', -- Default file icon
      },
      modified = {
        symbol = '[+]', -- Minimal modified indicator
      },
    },
    filesystem = {
      filtered_items = {
        visible = true, -- Hide hidden files by default
        hide_dotfiles = false,
        hide_gitignored = true,
      },
      follow_current_file = true, -- Sync with the current file
      hijack_netrw_behavior = 'open_default', -- Override netrw for a smoother experience
      window = {
        position = 'left', -- Position NeoTree on the left
        width = 30, -- Set a compact width
        mappings = {
          ['\\'] = 'close_window', -- Close NeoTree with the same key
          ['o'] = 'open', -- Simplified open mapping
        },
      },
      cwd_target = 'global', -- Set the root to the global working directory
    },
    event_handlers = {
      {
        event = 'vim_enter',
        handler = function()
          -- Automatically open NeoTree when opening Neovim in a directory
          require('neo-tree.command').execute { source = 'filesystem', position = 'left' }
        end,
      },
    },
  },
}
