-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

------------------
-- Will keymaps
------------------
vim.keymap.del({ "n", "t" }, "<C-/>")
vim.keymap.del("n", "[t")
vim.keymap.del("n", "]t")
vim.keymap.del("n", "<leader>br") -- Deletes the initial
vim.keymap.del("n", "<leader>bl")
-- vim.keymap.del("n", "<leader>cs") -- aerial remove
-- TODO: Remove the "[[" and "]]" commands from snacks, hand those to aerial
-- config = function(_, opts)
--   require("snacks").words.disable({
--
--   })(opts)
--   vim.keymap.del({ "n", "t" }, "[[")
--   vim.keymap.del({ "n", "t" }, "]]")
-- end,

-- Window keymaps
local map = vim.keymap.set
map("n", "<M-w>", "<C-w>q", { noremap = true, desc = "Kills the current window" })
map("n", "<M-v>", "<C-w>v", { noremap = true, desc = "Splits the current window" })
map("n", "<M-d>", function()
  Snacks.bufdelete()
end, { desc = "Deletes buffer in one command" })
map("n", "<M-m>", function()
  Snacks.zen.zoom()
end, { desc = "Maximize window" })
map("n", "]T", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment", silent = false })
map("n", "[T", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment", silent = true })
map("n", "]t", ":tabnext<CR>", { desc = "Next tab", remap = false })
map("n", "[t", ":tabprevious<CR>", { desc = "Last tab", remap = false })
vim.keymap.set("n", "<leader><Tab>r", function()
  local input = vim.fn.input("New tab name: ")
  if input ~= "" then
    vim.cmd("BufferLineTabRename " .. input)
  end
end, { desc = "Rename bufferline tab" })

map("n", "<M-q>", ":tabclose<CR>", { desc = "Close tab", remap = false })
map("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "Delete buffers to the Right" })
map("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "Delete buffers to the Left" })

-- Terminal/comment keymaps
-- TODO: Add commenting stuff
map("n", "<M-/>", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map("t", "<M-/>", "<cmd>close<CR>")
-- map({"n", "v", "i"}, "<M-/>", "<cmd>gcc<CR>", { desc = "Toggle comment", remap=false})

-- File explorer keymaps
map("n", "<M-e>", function()
  Snacks.explorer({ focus })
end, { desc = "Neotree focus" })
map("n", "<M-E>", function()
  Snacks.explorer({ cwd = LazyVim.root() })
end, { desc = "Neotree focus to CWD" })
-- map("n", "<leader>co", "<cmd>Outline<CR>", {desc = "Toggle Outline", noremap = true})

-- Movement keymaps
-- vim.keymap.set("n", "<A-T>", "tabclose<CR>", { noremap = true, silent = true, desc = "Close current tab" })
map({ "n", "i" }, "<C-ScrollWheelUp>", "5zl", { desc = "Scroll right" })
map({ "n", "i" }, "<C-ScrollWheelDown>", "5zh", { desc = "Scroll left" })

-- N behavior (not sure why this is weird)
-- map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
-- map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
-- map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
-- map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
-- map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
-- map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Git keymaps
map("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { noremap = true, desc = "Starts Fugitive Diff window" })
map("n", "<leader>gD", "<cmd>Git difftool -y develop<CR>", { noremap = true, desc = "Difftool against develop" })
map("n", "<leader>gm", "<cmd>Git mergetool<CR>", { noremap = true, desc = "Start mergetool, quicklist" })
map("n", "<leader>gM", "<cmd>Git mergetool -y<CR>", { noremap = true, desc = "Start mergetool, tabs" })
map("n", "<leader>gt", "<cmd>Gvdiffsplit!<CR>", { noremap = true, desc = "Start fugitive 3 way diff" })
map("n", "g2o", "<cmd>diffget //2<CR>", {noremap = true, desc = "Get changes from left window"})
map("n", "g3o", "<cmd>diffget //3<CR>", {noremap = true, desc = "Get changes from right window"})
-- Mergetool stuff
--   ╔═══════╦═══════╦════════╗
  -- ║       ║       ║        ║
  -- ║ LOCAL ║ MERGED║ REMOTE ║
  -- ║       ║       ║        ║
  -- ╚═══════╩═══════╩════════╝
-- do = get changes from current window
-- dp = Put changes to other window
-- :diffupdate = refresh diff highlighting
-- +----------------+------------------+
-- |     LOCAL      |      REMOTE     |
-- |  (your branch) | (their branch)  |
-- +----------------+------------------+
-- |             BASE                 |
-- |    (common ancestor)            |
-- +----------------+------------------+
-- |            MERGED               |
-- |     (final result)             |
-- +----------------+------------------+

-- Quickfix keymaps
map("n", "<leader>xc", "<cmd>cexpr []<CR>", { noremap = true, desc = "Clear the quickfix list" })

-- DocsViewToggle
map("n", "<leader>cD", "<cmd>DocsViewToggle<CR>", { noremap = true, desc = "Toggle docs to the right"})

-- Task runner keymaps (work in progress)
vim.api.nvim_set_keymap("n", "<F6>", "<cmd><cr>", { noremap = true, silent = true })
map("n", "<leader>cj", function()
  local schema = require("yaml-companion").get_buf_schema(0)
  if schema.result[1].name == "none" then
    return ""
  end
  return schema.result[1].name
end, { noremap = true, desc = "Shows current yaml/json schema loaded" })
vim.api.nvim_set_keymap("n", "<F6>", "<cmd>OverseerRun CMake Configure<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F7>", "<cmd>OverseerRun CMake Build<CR>", { noremap = true, silent = true })
map("n", "<leader>ms", "<cmd>CMakeSettings<CR>", { noremap = true, desc = "CMake Settings" })
map("n", "<leader>mr", "<cmd>CMakeRun<CR>", {noremap = true, desc="Run"})
map("n", "<leader>mR", "<cmd>CMakeQuickRun<CR>", {noremap=true, desc="CMake quick run"})
map("n", "<leader>mg", "<cmd>CMakeGenerate<CR>", { noremap = true, desc = "CMake Generate" })
map("n", "<leader>mm", "<cmd>CMakeBuild<CR>", { noremap = true, desc = "CMake Build" })
map("n", "<leader>mt", "<cmd>CMakeSelectBuildTarget<CR>", { noremap = true, desc = "Pick Build target" })
map("n", "<leader>ml", "<cmd>CMakeSelectLaunchTarget<CR>", { noremap = true, desc = "Pick Launch target" })
map("n", "<leader>ma", "<cmd>CMakeTargetSettings<CR>", { noremap = true, desc = "Target Settings (gtest_filter)" })
-- map("n", "<leader>mt", "<cmd>CMakeRunTest<CR>", { noremap = true, desc = "CMake Run Test" })

-- LSP keymaps
map("n", "<leader>cJ", function()
  require("yaml-companion").open_ui_select()
end, { noremap = true, desc = "Shows current yaml/json schema loaded" })
map({"n", "v"}, "<leader>cct", "<cmd>ClangdAST<CR>", { desc = "Clangd AST" })
map({"n", "v"}, "<leader>cci", "<cmd>ClangdSymbolInfo<CR>", { desc = "Clangd Symbol Info" })
map({"n", "v"}, "<leader>cch", "<cmd>ClangdTypeHierarchy<CR>", { desc = "Clangd Type Hierarchy" })
map({"n", "v"}, "<leader>ccm", "<cmd>ClangdMemoryUsage<CR>", { desc = "Clangd Memory Usage" })
map({"n", "v"}, "<leader>cL", "<cmd>LspInfo<CR>", { desc = "Lsp info cmd" })

-- Test keymaps
map("n", "<leader>tR", function()
  vim.ui.input({ prompt = "Test name to run: " }, function(input)
    if input and input ~= "" then
      require("neotest").run.run(input)
      else
        print("No test name provided.")
      end
  end)
end, {desc = "Run test by name", noremap = true, silent = true})
-- FIXME: Doesn't list all tests
-- vim.api.nvim_create_user_command("ListTests", function()
--   local neotest = require("neotest")
--   local tree = neotest.run.get_tree()
--   if not tree then
--     print("No tests loaded.")
--     return
--   end
--
--   tree:visit(function(node)
--     if node.type == "test" then
--       print(node.name)
--     end
--   end)
-- end, {})
-- map("n", "<leader>tL", "<cmd>ListTests<CR>", {desc = "List all tests", noremap = false})

-- FIXME: Doesn't run an exact test
-- vim.keymap.set("n", "<leader>tq", function()
--   vim.ui.input({ prompt = "Exact test name: " }, function(input)
--     if not input or input == "" then
--       print("❌ No test name entered.")
--       return
--     end
--
--     local neotest = require("neotest")
--     local positions = neotest.run.get_tree()
--     if not positions then
--       print("❌ No test tree loaded. Try opening a test file first.")
--       return
--     end
--
--     local found = nil
--     positions:visit(function(node)
--       if node.type == "test" and node.name == input then
--         found = node
--       end
--     end)
--
--     if found then
--       neotest.run.run(found)
--     else
--       print("❌ Test name not found: " .. input)
--     end
--   end)
-- end, { desc = "Run test by name", noremap = true, silent = true })


-- DAP Keymaps
map("n", "<leader>dv", "<Cmd>DapViewToggle<CR>", {desc = "Toggle DAP view", noremap = true})
-- FIXME: Not working
-- map("n", "F5",
--   local dap = require("dap")
--   if dap.session() == nil and (vim.bo.filetype == "cpp" or vim.bo.filetype == "c") then
--     -- Only call this on C++ and C files
--     require("ctest-telescope").pick_test_and_debug()
--   else
--     dap.continue()
--   end
-- end, { desc = "Debug: Start/Continue" })

-- Searching keymaps
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>s/", LazyVim.pick("files", { root = false }), { desc = "Grep (cwd)", noremap = true })
vim.keymap.del("n", "<leader>sg")
vim.keymap.del("n", "<leader>sG")

------------------
-- Will Functions
------------------
local list_snips = function()
  local ft_list = require("luasnip").available()[vim.o.filetype]
  local ft_snips = {}
  for _, item in pairs(ft_list) do
    ft_snips[item.trigger] = item.name
  end
  print(vim.inspect(ft_snips))
end
vim.api.nvim_create_user_command("SnipList", list_snips, {})
