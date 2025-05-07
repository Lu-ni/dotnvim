local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action() -- Use lsp-zero's cmp actions for snippets

cmp.setup({
--  window = {
--    completion = cmp.config.window.bordered(),
--    documentation = cmp.config.window.bordered(),
--  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Requires luasnip
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),   -- Confirm with Enter
    ['<C-Space>'] = cmp.mapping.complete(),            -- Manually trigger completion
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),     -- Luasnip jump forward (requires luasnip)
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),    -- Luasnip jump backward (requires luasnip)
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),           -- Scroll documentation up
    ['<C-d>'] = cmp.mapping.scroll_docs(4),            -- Scroll documentation down
    ['<Tab>'] = cmp.mapping.select_next_item(),        -- Select next item
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),      -- Select previous item
    ['<C-e>'] = cmp.mapping.abort(),                 -- Close completion window
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- Source for LSP suggestions
    { name = 'luasnip' },  -- Source for snippets (requires luasnip)
  })
})
lsp_zero.set_sign_icons({
    error = '',
    warn = '',
    hint = '',
    info = ''
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "clangd", "pylsp" },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})

-- Setup for Lua language server
require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

-- Setup for Python LSP
require("lspconfig").pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pylint = {
                    enabled = true,  -- Enable pylint
                },
                pyflakes = { enabled = false },  -- Disable pyflakes
                pycodestyle = { enabled = false },  -- Disable pycodestyle
            },
        },
    },
})

-- Configure diagnostics to only show errors and warnings
vim.diagnostic.config({
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN }
    },
    signs = {
        severity = { min = vim.diagnostic.severity.WARN }
    },
    float = {
        severity = { min = vim.diagnostic.severity.WARN }
    },
    underline = {
        severity = { min = vim.diagnostic.severity.WARN }
    },
    update_in_insert = false,
    severity_sort = true,
})

-- Function to toggle diagnostics
local diagnostics_active = true

function ToggleDiagnostics()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.enable()
    else
        vim.diagnostic.disable()
    end
end

-- Set up a keybinding to toggle diagnostics
vim.api.nvim_set_keymap('n', '<leader>D', ':lua ToggleDiagnostics()<CR>', { noremap = true, silent = true })
-- Explicit Global mapping for Code Action
vim.api.nvim_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = "LSP Code Action (Global)" })
