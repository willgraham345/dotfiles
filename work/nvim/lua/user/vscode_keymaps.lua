local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap(
  { "n", "v" },
  "<leader>j",
  "<cmd> lua require('vscode').action('workbench.ac/home/will/repos/stoneward/.cacheshowCommands')<CR>"
)
-- buffers
keymap({ "n" }, "<leader>bo", "<cmd> lua require('vscode').action('workbench.actioneOtherEditors')<CR>") -- Closes editors in group
keymap({ "n" }, "<leader>bD", "<cmd> lua require('vscode').action('workbench.actioneEditorsInOtherGroups')<CR>") -- close editors in other groups
keymap({ "n" }, "<leader>bl", "<cmd> lua require('vscode').action('workbench.actioneEditorsToTheLeft')<CR>")
keymap({ "n" }, "<leader>bh", "<cmd> lua require('vscode').action('workbench.actioneEditorsToTheRight')<CR>")

keymap({ "n", "v" }, "gk", "<cmd> lua require('vscode').action('showHover')<CR>")
keymap({ "n", "v" }, "K", "<cmd> lua require('vscode').action('showHover')<CR>")

-- Code navigation keymaps
-- TODO: Figure out how the movement works in vscode, and where it's different in neovim
keymap({ "n", "v" }, "gR", "<cmd> lua require('vscode').action('editor.action.referenceSerch.trigger')<CR>")
keymap({ "n", "v" }, "gy", "<cmd> lua require('vscode').action('editor.action.peekDeclaration')<CR>")
keymap({ "n", "v" }, "gY", "<cmd> lua require('vscode').action('editor.action.revealDeclaration')<CR>")
-- TODO: Add stuff for collapsing/folding various stuff

-- keymap({ "n", "v" }, "L", "<cmd> lua require('vscode').action('workbench.action.nextEditor')<CR>")
-- keymap({ "n", "v" }, "H", "<cmd> lua require('vscode').action('workbench.action.previousEditor')<CR>")
-- -- yank to system clipboard
-- keymap({ "n", "v" }, "<leader>y", '"+y', opts)

-- -- paste from system clipboard
-- keymap({ "n", "v" }, "<leader>p", '"+p', opts)
--
-- -- better indent handling
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)
--
-- move text up and down
-- keymap("v", "J", ":m .+1<CR>==", opts)
-- keymap("v", "K", ":m .-2<CR>==", opts)
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
--

-- -- paste preserves primal yanked piece
-- keymap("v", "p", '"_dP', opts)

-- -- removes highlighting after escaping vim search
-- keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

-- call vscode commands from neovim

-- general keymaps
keymap({ "n", "v" }, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
keymap({ "n", "v" }, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
-- keymap({ "n", "v" }, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap({ "n", "v" }, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap({ "n", "v" }, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
keymap({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
keymap({ "n", "v" }, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap({ "n", "v" }, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
keymap({ "n", "v" }, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
keymap({ "n", "v" }, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
--
-- harpoon keymaps
-- keymap({ "n", "v" }, "<leader>H", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
-- keymap({ "n", "v" }, "<leader>h", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
-- keymap({ "n", "v" }, "<leader>he", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
-- keymap({ "n", "v" }, "<leader>1", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
-- keymap({ "n", "v" }, "<leader>2", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
-- keymap({ "n", "v" }, "<leader>3", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
-- keymap({ "n", "v" }, "<leader>4", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
-- keymap({ "n", "v" }, "<leader>5", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
-- keymap({ "n", "v" }, "<leader>6", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
-- keymap({ "n", "v" }, "<leader>7", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
-- keymap({ "n", "v" }, "<leader>8", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
-- keymap({ "n", "v" }, "<leader>9", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")
--
-- project manager keymaps
-- keymap({ "n", "v" }, "<leader>pa", "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
-- keymap({ "n", "v" }, "<leader>po", "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")
-- keymap({ "n", "v" }, "<leader>pe", "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")
