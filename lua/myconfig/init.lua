require("myconfig.remap")
require("myconfig.set")

-- CAPTURE the module in a variable named cpp_utils
local cpp_utils = require("myconfig.my_cpp_utils")

vim.api.nvim_create_user_command(
  'MyCreateCppClass',
  cpp_utils.create_class_pair,
  { nargs = 1 }
)
