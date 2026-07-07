-- ~/.config/nvim/lua/my_cpp_utils.lua
local M = {}

-- Helper function to check if a file exists
local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

-- Helper function to write lines to a file
local function write_to_file(path, lines)
  local f = io.open(path, "w")
  if not f then return false end
  for _, line in ipairs(lines) do
    f:write(line .. "\n")
  end
  f:close()
  return true
end

--- Creates .hpp and .cpp files for a C++ class in Orthodox Canonical Form
-- @param args The arguments passed to the command (the class name)
function M.create_class_pair(opts)
  local classname = opts.args

  -- Validate input
  if not classname or classname == "" then
    vim.notify("Please provide a class name.", vim.log.levels.ERROR)
    return
  end

  local hpp_filename = classname .. ".hpp"
  local cpp_filename = classname .. ".cpp"

  -- Prevent overwriting existing files
  if file_exists(hpp_filename) or file_exists(cpp_filename) then
    vim.notify("Error: Files for '" .. classname .. "' already exist.", vim.log.levels.ERROR)
    return
  end

  -- 1. Generate Content for HPP
  local hpp_lines = {
    '#pragma once',
    '',
    '#include <iostream>',
    '',
    'class ' .. classname .. ' {',
    ' public:',
    '  ' .. classname .. '();',                                         -- Default Constructor
    '  ' .. classname .. '(const ' .. classname .. '& other);',          -- Copy Constructor
    '  ' .. classname .. '& operator=(const ' .. classname .. '& other);', -- Copy Assignment Operator
    '  ~' .. classname .. '();',                                         -- Destructor
    '',
    ' private:',
    '',
    '};',
  }

  -- 2. Generate Content for CPP
  local cpp_lines = {
    '#include "' .. hpp_filename .. '"',
    '',
    '// Default Constructor',
    classname .. '::' .. classname .. '() {',
    '}',
    '',
    '// Copy Constructor',
    classname .. '::' .. classname .. '(const ' .. classname .. '& other) {',
    '  *this = other;',
    '}',
    '',
    '// Copy Assignment Operator',
    classname .. '& ' .. classname .. '::operator=(const ' .. classname .. '& other) {',
    '  if (this != &other) {',
    '    // super::operator=(other);',
    '    // _member = other._member;',
    '  }',
    '  return *this;',
    '}',
    '',
    '// Destructor',
    classname .. '::' .. classname .. '::~' .. classname .. '() {',
    '}',
  }

  -- 3. Write files
  local hpp_ok = write_to_file(hpp_filename, hpp_lines)
  local cpp_ok = write_to_file(cpp_filename, cpp_lines)

  if hpp_ok and cpp_ok then
    vim.notify("Created " .. hpp_filename .. " and " .. cpp_filename, vim.log.levels.INFO)
    
    -- Open the files (Open cpp, then split open hpp)
    vim.cmd("edit " .. cpp_filename)
    vim.cmd("vsplit " .. hpp_filename)
  else
    vim.notify("Error writing files.", vim.log.levels.ERROR)
  end
end

return M
