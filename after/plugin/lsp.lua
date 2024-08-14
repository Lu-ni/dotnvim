local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

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
                    enabled = true,  -- Disable pylint
                },
                pyflakes = { enabled = false },  -- Disable pyflakes
                pycodestyle = { enabled = false },  -- Disable pycodestyle
            },
        },
    },
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
vim.api.nvim_set_keymap('n', '<leader>d', ':lua ToggleDiagnostics()<CR>', { noremap = true, silent = true })

