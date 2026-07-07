vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "File Explorer (Netrw)" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search match and center" })
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "LSP: Restart" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste and keep register" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete and keep register" })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>F", function()
    require("conform").format({ lsp_fallback = "always", async = false, timeout_ms = 500 })
end, { desc = "Format file (conform)" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Quickfix: Next" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Quickfix: Previous" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Loclist: Next" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Loclist: Previous" })

vim.keymap.set("n", "<leader>D", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "LSP: Toggle diagnostics" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search/Replace current word" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal: Exit to normal mode" })
