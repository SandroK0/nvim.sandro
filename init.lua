-- init.lua (Main entry point for Neovim configuration)
-- This file loads all modular configurations.

-- Load general settings
require 'settings'

-- Load plugin configurations
require 'plugins.init'

-- Load key mappings
require 'keymaps'

-- Load autocommands
require 'autocmds'

-- Utility functions
require 'utils'
