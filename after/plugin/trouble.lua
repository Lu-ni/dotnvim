local trouble = require("trouble")

-- Set up trouble keymaps
vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)

-- Re-map grr to use Trouble with follow disabled and focus enabled
vim.keymap.set("n", "grr", function()
    trouble.toggle({
        mode = "lsp_references",
        follow = false, -- Don't change the list when you move your cursor
        focus = true,   -- Jump straight into the Trouble window
    })
end, { desc = "Trouble: LSP References" })
