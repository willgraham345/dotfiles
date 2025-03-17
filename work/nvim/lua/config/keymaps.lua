-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Will keymaps
local map = vim.keymap.set
map("n", "<M-e>", function()
  Snacks.explorer({ focus })
end, { desc = "Neotree focus" })
map("n", "<M-m>", function()
  Snacks.zen.zoom()
end, { desc = "Maximize window" })
map("n", "<M-d>", function()
  Snacks.bufdelete()
end, { desc = "Deletes buffer in one command" })
map("n", "<leader>gd", function()
  vim.cmd("Neogit")
end, { noremap = true, desc = "Starts neovim diff window" })
map("n", "<leader>wp", function()
  local picked_window_id = require("window-picker").pick_window()
end, { noremap = true, desc = "Triggers picking a window" })
map("n", "<C-w>p", function()
  local picked_window_id = require("window-picker").pick_window()
end, { noremap = true, desc = "Triggers picking a window" })

map("n", "<leader>xc", function()
  vim.cmd("command! ClearQuickfixList cexpr []")
end, { noremap = true, desc = "Clear the quickfix list" })

-- Removed keymaps

-- Vscode commands
local function copyToClipBoard()
  vim.cmd("set clipboard+=unnamedplus")
  vim.cmd("norm! y")
  vim.cmd("set clipboard-=unnamedplus")
  print("copied!")
end

local function callVSCodeFunction(vsCodeCommand)
  vim.cmd(vsCodeCommand)
end

map("i", "<C-a>", function()
  vim.cmd("norm! ggVG")
  print("Selected all lines")
end, { remap = false, desc = "select all lines in buffer" })
map({ "v", "i" }, "<C-c>", function()
  copyToClipBoard()
end, { remap = false, desc = "copy selected text" })
-- map("i", "<C-l>", "<Del>", { remap = true, desc = "delete one character backward" })
local function neovimMappings()
  -- map(
  --   { "i", "t" },
  --   "<C-j>",
  --   "<cmd>ToggleTerm direction=float<CR><Esc>i",
  --   { desc = "open floating terminal", noremap = false }
  -- )

  map("i", "<C-d>", function()
    local new_text = vim.fn.input("Replace with?: ")
    local cmd = "normal! *Ncgn" .. new_text
    vim.cmd(cmd)
  end, { desc = "ctrl+d vs code alternative" })

  map("i", "<C-f>", "<Esc>/", { noremap = false })

  -- Map a keybinding to toggle word wrap
  map("n", "<leader>ct", function()
    ToggleWordWrap()
  end, { noremap = true, silent = true, desc = "toggle word wrap" })
  map("n", "<leader>bc", "<cmd>BufferLinePick<CR>", { noremap = false, silent = true, desc = "pick buffer" })
end

local function vscodeMappings()
  map("n", "<leader>j", function()
    callVSCodeFunction("call VSCodeCall('workbench.action.showCommands')")
  end, { noremap = true, silent = true, desc = "Execute command" })

  map("n", "<C-/>", function()
    callVSCodeFunction("call VSCodeCall('workbench.action.terminal.focus')")
  end, { noremap = true, silent = true, desc = "toggle terminal" })

  map("t", "<C-l>", function()
    print("next term")
    callVSCodeFunction("call VSCodeCall('workbench.action.terminal.focusNextPane')")
  end, { noremap = true, silent = true, desc = "cycle terminal focus" })

  map("t", "<C-h>", function()
    print("prev term")
    callVSCodeFunction("call VSCodeCall('workbench.action.terminal.focusPreviousPane')")
  end, { noremap = true, silent = true, desc = "cycle terminal focus" })

  map("n", "<leader>cs", function()
    print("go to symbols in editor")
    callVSCodeFunction("call VSCodeCall('workbench.action.gotoSymbol')")
  end, { noremap = true, silent = true, desc = "go to symbols in editor" })

  map("n", "<S-l>", function()
    callVSCodeFunction("call VSCodeNotify('workbench.action.nextEditor')")
  end, { noremap = true, desc = "switch between editor to next" })

  map("n", "<S-h>", function()
    callVSCodeFunction("call VSCodeNotify('workbench.action.previousEditor')")
  end, { noremap = true, desc = "switch between editor to previous" })

  map("n", "gr", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.referenceSearch.trigger')")
  end, { noremap = true, desc = "peek references inside vs code" })

  map("n", "<leader>sd", function()
    callVSCodeFunction("call VSCodeNotify('workbench.action.problems.focus')")
  end, { noremap = true, desc = "open problems and errors infos" })

  map("n", "<leader>e", function()
    callVSCodeFunction("call VSCodeNotify('workbench.files.action.focusFilesExplorer')")
  end, { noremap = true, desc = "focus to file explorer" })

  map("n", "<leader>fe", function()
    callVSCodeFunction("call VSCodeNotify('workbench.files.action.focusFilesExplorer')")
  end, { noremap = true, desc = "focus to file explorer" })

  map("n", "<leader>ff", function()
    callVSCodeFunction("call VSCodeNotify('workbench.action.quickOpen')")
  end, { noremap = true, desc = "open files" })

  map("n", "<leader>gg", function()
    callVSCodeFunction("call VSCodeNotify('workbench.view.scm')")
  end, { noremap = true, desc = "open git source control" })

  map("n", "<leader>sml", function()
    callVSCodeFunction("call VSCodeNotify('bookmarks.list')")
  end, { noremap = true, desc = "open bookmarks list for current files" })

  map("n", "<leader>smL", function()
    callVSCodeFunction("call VSCodeNotify('bookmarks.listFromAllFiles')")
  end, { noremap = true, desc = "open bookmarks list for all files" })

  map("n", "<leader>smm", function()
    callVSCodeFunction("call VSCodeNotify('bookmarks.toggle')")
  end, { noremap = true, desc = "toggle bookmarks" })

  map("n", "<leader>smd", function()
    callVSCodeFunction("call VSCodeNotify('bookmarks.clear')")
  end, { noremap = true, desc = "clear bookmarks from current file" })

  map("n", "<leader>smr", function()
    callVSCodeFunction("call VSCodeNotify('bookmarks.clearFromAllFiles')")
  end, { noremap = true, desc = "clear bookmarks from all file" })

  map("n", "<leader>cr", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.rename')")
  end, { noremap = true, desc = "rename symbol" })

  map("n", "<leader>ca", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.quickFix')")
  end, { noremap = true, desc = "open quick fix in vs code" })

  map("n", "<leader>cA", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.sourceAction')")
  end, { noremap = true, desc = "open source Action in vs code" })

  map("n", "<leader>cp", function()
    callVSCodeFunction("call VSCodeNotify('workbench.panel.markers.view.focus')")
  end, { noremap = true, desc = "open problems diagnostics" })

  map("n", "<leader>cd", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.marker.next')")
  end, { noremap = true, desc = "open problems diagnostics" })

  map({ "v" }, "<C-c>", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.clipboardCopyAction')")
    print("📎added to clipboard!")
  end, { noremap = true, desc = "copy text/add text to clipboard" })

  map({ "n" }, "u", function()
    callVSCodeFunction("call VSCodeNotify('undo')")
  end, { noremap = true, desc = "undo changes" })

  map("n", "<C-r>", function()
    callVSCodeFunction("call VSCodeNotify('redo')")
  end, { noremap = true, desc = "redo changes" })

  map("n", "<leader>bo", function()
    callVSCodeFunction("call VSCodeNotify('workbench.actioneOtherEditors')")
  end, { noremap = true, desc = "Closes other editor groups" })

  map("n", "<leader>bD", function()
    callVSCodeFunction("call VSCodeNotify('workbench.actioneEditorsInOtherGroups')")
  end, { noremap = true, desc = "Close editors in other groups" })

  map("n", "<leader>bl", function()
    callVSCodeFunction("call VSCodeNotify('workbench.actioneEditorsToTheLeft')")
  end, { noremap = true, desc = "Closes editors to the left" })

  map("n", "<leader>bh", function()
    callVSCodeFunction("call VSCodeNotify('workbench.action.closeEditorsToTheRight')")
    print("Closed editors to the right")
  end, { noremap = true, desc = "Closes editors to the right" })
end

if vim.g.vscode then
  print("⚡connected to neovim!💯‼️🤗😎")
  vscodeMappings()
else
  neovimMappings()
end
