-- local FileUtilities = require("utilities.file_utilities")
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.loader.enable()
--
-- -- Set working directory
-- if vim.fn.argc() == 1 then
--   local arg = vim.fn.argv()[1]
--   -- If the argument is a non-existing directory, create it
--   if arg:sub(-1) == "/" and not FileUtilities.isDirectory(arg) then
--     -- Create the directory
--     vim.fn.mkdir(arg, "p")
--   end
--
--   if FileUtilities.isDirectory(arg) then
--     vim.cmd("cd " .. arg)
--   end
-- end
-- Detect toolchains
_G.HAS_RUST = vim.fn.executable("rustc") == 1
_G.HAS_CPP = vim.fn.executable("g++") == 1 or vim.fn.executable("clang++") == 1

-- Optional: Print diagnostics
if HAS_RUST then
  print("[init] Rust toolchain detected")
else
  print("[init] Rust toolchain not found")
end

if HAS_CPP then
  print("[init] C++ toolchain detected")
else
  print("[init] C++ toolchain not found")
end

-- Now you can use HAS_RUST and HAS_CPP in plugin specs or other Lua config

require("config.lazy")
-- Set colorscheme

-- require("snacks").explorer()
vim.cmd("colorscheme sonokai")
-- require("aerial").setup({
--   -- optionally use on_attach to set keymaps when aerial has attached to a buffer
--   on_attach = function(bufnr)
--     -- Jump forwards/backwards with '{' and '}'
--     vim.keymap.set("n", "[o", "<cmd>AerialPrev<CR>", { desc = "AerialPrev", buffer = bufnr , noremap = false})
--     vim.keymap.set("n", "]o", "<cmd>AerialNext<CR>", { desc = "AerialNext", buffer = bufnr , noremap = false})
--   end,
-- })
-- You probably also want to set a keymap to toggle aerial
-- vim.keymap.set("n", "<leader>cs", "<cmd>AerialToggle!<CR>")
