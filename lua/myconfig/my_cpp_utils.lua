-- ~/.config/nvim/lua/my_cpp_utils.lua
-- (or any other location in your Lua runtime path, e.g., lua/utils/cpp.lua)

-- This module provides utility functions for C++ development in Neovim.
local M = {}

--- Generates C++ header boilerplate following the Orthodox Canonical Form (OCF).
-- Inserts include guards, class definition with default constructor,
-- copy constructor, copy assignment operator, and virtual destructor.
-- @usage Call this function from a command or mapping, e.g.,
-- vim.api.nvim_create_user_command('GenHpp', M.generate_hpp_boilerplate, {})
function M.generate_hpp_boilerplate()
  -- Get the current buffer handle (0 for current buffer)
  local buf = 0

  -- Check if the buffer is empty (only 1 line which is empty)
  if vim.fn.line('$') ~= 1 or vim.fn.getline(1) ~= '' then
    vim.notify("Buffer is not empty. Boilerplate not generated.", vim.log.levels.WARN)
    return
  end

  -- Get the full filename (e.g., MyClass.hpp)
  local filename = vim.fn.expand('%:t')
  if filename == '' then
    vim.notify("Cannot generate boilerplate: No filename.", vim.log.levels.ERROR)
    return
  end

  -- Basic check for .hpp or .h extension - adapt if you use other extensions
  if not string.match(filename, "%.hpp$") and not string.match(filename, "%.h$") then
      vim.notify("Warning: File does not end with .hpp or .h.", vim.log.levels.WARN)
      -- Consider returning here if strict adherence to .hpp/.h is required:
      -- return
  end


  -- Get the filename without extension (e.g., MyClass) to use as the class name
  local classname = vim.fn.expand('%:t:r')
  -- Optional: Sanitize classname if filenames can contain invalid characters
  -- classname = string.gsub(classname, "[^A-Za-z0-9_]", "_")

  -- Generate the include guard symbol (e.g., MY_CLASS_HPP)
  -- Replaces non-alphanumeric characters with underscores and converts to uppercase.
  local guard_symbol = string.upper(string.gsub(filename, '[^A-Za-z0-9]', '_'))

  -- Define the lines of code for the OCF boilerplate
  local lines = {
    '#pragma once ',
    '', -- Empty line for separation
    'class ' .. classname .. ' {',
    ' public:',
    '  ' .. classname .. '();',                                -- Default Constructor
    '  ' .. classname .. '(const ' .. classname .. '& other);', -- Copy Constructor
    '  ' .. classname .. '& operator=(const ' .. classname .. '& other);', -- Copy Assignment Operator
    '  virtual ~' .. classname .. '();',                      -- Virtual Destructor (good practice)
    '',
    ' private:',
    '  // Private members go here', -- Placeholder comment for private section
    '',
    '};',
  }

  -- Replace the entire buffer content (start=0, end=-1, strict_indexing=false)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Optional: Move the cursor to a convenient position,
  -- e.g., inside the private section.
  -- Lines are 1-based, columns are 0-based for set_cursor.
  -- Move to line 12 (line with '// Private members go here'), column 2 (indented).
  vim.api.nvim_win_set_cursor(0, {12, 2})

  vim.notify("OCF HPP boilerplate generated for " .. classname, vim.log.levels.INFO)
end

return M

