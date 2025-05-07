require("myconfig.remap")
require("myconfig.set")
require("myconfig.my_cpp_utils")
-- In your init.lua or similar

-- Define a user command :HppBoilerplate
vim.api.nvim_create_user_command(
  'HppBoilerplate',          -- Command name
  'lua require("myconfig.my_cpp_utils").generate_hpp_boilerplate()', -- Action to perform
  { desc = 'Generate C++ HPP boilerplate' } -- Optional description
)

-- Optional: Create a keymap (e.g., <leader>hb in normal mode)
-- <leader> is often mapped to '\' or ' ' (space)
vim.keymap.set('n', '<leader>hb', '<Cmd>HppBoilerplate<CR>', {
  noremap = true,
  silent = true,
  desc = 'Generate HPP Boilerplate' -- Description for :map or which-key
})
