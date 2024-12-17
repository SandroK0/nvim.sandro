return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre', 'BufReadPre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format {
          async = true,
          lsp_fallback = true,
          timeout_ms = 1000,
        }
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat buffer',
    },
  },
  config = function()
    local conform = require 'conform'

    conform.setup {
      -- Disable format on save for large files
      format_on_save = function(bufnr)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local file_size = vim.fn.getfsize(bufname)

        -- Skip formatting for files larger than 100KB
        if file_size > 100 * 1024 then
          return
        end

        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style.
        local disable_filetypes = {
          c = true,
          cpp = true,
        }

        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end

        return {
          timeout_ms = 500,
          lsp_fallback = lsp_format_opt == 'fallback',
        }
      end,

      -- More comprehensive formatters configuration
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        python = { 'isort', 'autopep8' }, -- Added isort for import sorting
        html = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        json = { 'jq', 'prettier' }, -- Multiple formatters with precedence
        jsonc = { 'jq', 'prettier' },
        markdown = { 'prettier' },
        yaml = { 'prettier' },
        php = { 'pretty-php' },
        go = { 'gofmt', 'goimports' }, -- Added goimports
        rust = { 'rustfmt' },
        vue = { 'prettier' },
        svelte = { 'prettier' },
        graphql = { 'prettier' },

        -- Fallback formatters
        ['_'] = { 'trim_whitespace', 'trim_newlines' },
      },

      -- Specific formatter options
      formatters = {
        -- Custom configurations for specific formatters
        stylua = {
          prepend_args = { '--indent-type', 'Spaces', '--indent-width', '4' },
        },
        prettier = {
          -- Allow configuration via .prettierrc
          require_stdin = true,
          -- Respect project-specific Prettier config
          condition = function(ctx)
            return vim.fs.find({
              '.prettierrc',
              '.prettierrc.json',
              '.prettierrc.yml',
              '.prettierrc.yaml',
              '.prettierrc.toml',
              'prettier.config.js',
              '.prettierrc.js',
              '.prettierrc.mjs',
              '.prettierrc.cjs',
            }, {
              upward = true,
              path = ctx.dirname,
            })
          end,
        },
        autopep8 = {
          -- Max line length for Python
          prepend_args = { '--max-line-length', '120' },
        },
      },
    }

    -- Create a command to disable format on save
    vim.api.nvim_create_user_command('ConformToggleFormatOnSave', function()
      local conform = require 'conform'
      local current_format_on_save = conform.resolve_format_on_save()

      if current_format_on_save then
        conform.setup { format_on_save = false }
        print 'Format on save disabled'
      else
        conform.setup {
          format_on_save = function(bufnr)
            -- Reuse the previous format_on_save logic
            local disable_filetypes = {
              c = true,
              cpp = true,
            }

            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
              lsp_format_opt = 'never'
            else
              lsp_format_opt = 'fallback'
            end

            return {
              timeout_ms = 500,
              lsp_fallback = lsp_format_opt == 'fallback',
            }
          end,
        }
        print 'Format on save enabled'
      end
    end, {})
  end,
}
