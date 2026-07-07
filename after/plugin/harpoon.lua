local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Quick Menu" })

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: Select 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: Select 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: Select 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: Select 4" })
vim.keymap.set("n", "<leader>r1", function() harpoon:list():replace_at(1) end, { desc = "Harpoon: Replace 1" })
vim.keymap.set("n", "<leader>r2", function() harpoon:list():replace_at(2) end, { desc = "Harpoon: Replace 2" })
vim.keymap.set("n", "<leader>r3", function() harpoon:list():replace_at(3) end, { desc = "Harpoon: Replace 3" })
vim.keymap.set("n", "<leader>r4", function() harpoon:list():replace_at(4) end, { desc = "Harpoon: Replace 4" })
