local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Use ruff for python formatting and import organizing
        python = { "ruff_organize_imports", "ruff_format" },
        -- Use clang-format for C/C++
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettier" },
        htmldjango = { "djlint" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
})

-- Keymap to manually trigger formatting
vim.keymap.set({ "n", "v" }, "<leader>f", function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end, { desc = "Format file or range (conform)" })
