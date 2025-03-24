local FileUtilities = require("utilities.file_utilities")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.loader.enable()

-- Set working directory
if vim.fn.argc() == 1 then
  local arg = vim.fn.argv()[1]
  -- If the argument is a non-existing directory, create it
  if arg:sub(-1) == "/" and not FileUtilities.isDirectory(arg) then
    -- Create the directory
    vim.fn.mkdir(arg, "p")
  end

  if FileUtilities.isDirectory(arg) then
    vim.cmd("cd " .. arg)
  end
end
require("config.lazy")
-- Set colorscheme
vim.cmd("colorscheme sonokai")
