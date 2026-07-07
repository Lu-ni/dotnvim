-- ============================================================================
-- Autocompletion (blink.cmp)
-- ============================================================================
require('blink.cmp').setup({
    -- See https://cmp.saghen.dev/configuration/keymap
    keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<C-Space>'] = { 'show', 'hide' },
    },

    completion = {
        -- Preselect the first item so <CR> accepts it (like the old config).
        list = { selection = { preselect = true, auto_insert = false } },
        -- Only pop the docs window on demand, keeps the menu lean.
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },

    -- This is the fix for "type 1, get suggested 100": the buffer source only
    -- kicks in for longer words and is capped, so LSP results stay on top.
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            buffer = {
                min_keyword_length = 4, -- ignore short tokens / numbers
                max_items = 5,
                score_offset = -3, -- rank buffer words below LSP results
            },
            snippets = { min_keyword_length = 2 },
        },
    },

    -- Rust fuzzy matcher with proper typo/frequency ranking.
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- friendly-snippets via the native 0.11 snippet engine.
    snippets = { preset = 'default' },
})

-- ============================================================================
-- LSP keymaps (on attach)
-- ============================================================================
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP keymaps',
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
            vim.tbl_extend('force', opts, { desc = 'LSP: Go to Definition' }))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover,
            vim.tbl_extend('force', opts, { desc = 'LSP: Hover Info' }))
        vim.keymap.set('n', '<leader>lca', vim.lsp.buf.code_action,
            vim.tbl_extend('force', opts, { desc = 'LSP: Code Action' }))
        vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename,
            vim.tbl_extend('force', opts, { desc = 'LSP: Rename' }))
    end,
})

-- ============================================================================
-- LSP servers (native vim.lsp.config, Neovim 0.11+)
-- ============================================================================
-- Hand blink's completion capabilities to every server.
vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })

vim.lsp.config('clangd', {
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'tpp' },
})

vim.lsp.config('ruff', {
    init_options = { settings = { lineLength = 120 } },
})

-- basedpyright = the completion/type server for Python (jedi/pylsp can't see
-- globals injected via __builtins__.py, e.g. The Farmer Was Replaced builtins).
-- __builtins__.py is added as a root marker so folders without pyproject/.git
-- (like a TFWR save dir) still root the project and load the builtins globally
-- instead of falling back to single-file mode.
vim.lsp.config('basedpyright', {
    root_markers = {
        'pyrightconfig.json', 'pyproject.toml', 'setup.py',
        'setup.cfg', 'requirements.txt', '__builtins__.py', '.git',
    },
    settings = {
        basedpyright = {
            analysis = {
                -- 'recommended' (the default) is very noisy; 'standard' keeps
                -- real type errors without flooding TFWR scripts with warnings.
                typeCheckingMode = 'standard',
                diagnosticSeverityOverrides = {
                    reportMissingModuleSource = 'none',
                },
            },
        },
    },
})

vim.lsp.config('lua_ls', {
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'clangd', 'ruff', 'basedpyright', 'lua_ls', 'html', 'emmet_ls', 'jinja_lsp' },
    -- mason-lspconfig v2 auto-enables installed servers via vim.lsp.enable.
    -- pylsp is excluded: basedpyright handles Python completion/types and, unlike
    -- pylsp/jedi, resolves globals from __builtins__.py. Leaving both on would
    -- give duplicate (and wrong) completions.
    automatic_enable = { exclude = { 'pylsp' } },
})

-- ============================================================================
-- Diagnostics
-- ============================================================================
vim.diagnostic.config({
    virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
    signs = {
        severity = { min = vim.diagnostic.severity.WARN },
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
        },
    },
    update_in_insert = false,
    severity_sort = true,
})

vim.cmd [[ autocmd BufRead,BufNewFile *.tpp set filetype=cpp ]]
