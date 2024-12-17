return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            build = function()
                -- Build step for regex support in snippets, check for Windows and `make` availability
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end,
        },
        'saadparwaiz1/cmp_luasnip', -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp', -- LSP source
        'rafamadriz/friendly-snippets', -- Friendly snippets source
    },
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'

        -- Lazy load VSCode snippets
        require('luasnip.loaders.from_vscode').lazy_load()

        -- LuaSnip configuration
        luasnip.config.setup {}

        -- nvim-cmp setup
        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- Expand snippets with LuaSnip
                end,
            },
            completion = {
                completeopt = 'menu,menuone,noinsert', -- Configure completion options
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                -- Tab and Shift-Tab for navigating through suggestions
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            sources = {
                { name = 'nvim_lsp' }, -- LSP completions
                { name = 'luasnip' }, -- Snippet completions
                { name = 'path' }, -- Path completions
                { name = 'buffer' }, -- Buffer completions
                { name = 'calc' }, -- Math calculations
            },
        }
    end,
}
