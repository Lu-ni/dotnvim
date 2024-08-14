-- Create an augroup for autoformat settings
local autoformat_settings = vim.api.nvim_create_augroup("autoformat_settings", { clear = true })

-- Add autocmds to the augroup
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "proto", "javascript", "typescript", "arduino" },
  command = "AutoFormatBuffer clang-format",
  group = autoformat_settings,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = "AutoFormatBuffer black",
  group = autoformat_settings,
})

