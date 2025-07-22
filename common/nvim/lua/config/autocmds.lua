-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Set focused directory as current working directory
local set_cwd = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify("Cursor is not on valid entry")
  end
  print("cd into: ", vim.fs.dirname(path))
  vim.fn.chdir(vim.fs.dirname(path))
end

-- Yank in register full path of entry under cursor
local yank_path = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify("Cursor is not on valid entry")
  end
  vim.fn.setreg(vim.v.register, path)
end

local sync_and_close_minifiles = function()
  -- Perform the refresh action, similar to MiniFiles.refresh()
  MiniFiles.synchronize()
  -- Close the mini.files buffer
  MiniFiles.close()
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local b = args.data.buf_id
    vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
    vim.keymap.set("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
    vim.keymap.set("n", "<Space>", sync_and_close_minifiles, { buffer = b, desc = "Sync and close" })
  end,
})

-- Always show bufferline/tabline
-- vim.api.nvim_create_autocmd("BufReadPre", {
--   group = vim.api.nvim_create_augroup("showtabline", { clear = true }),
--   callback = function()
--     vim.opt.showtabline = 0
--   end,
--   desc = "Set tabline to 0",
-- })

-- local luasnip = require("luasnip")
--
-- local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true })
--
-- vim.api.nvim_create_autocmd("ModeChanged", {
--   group = unlinkgrp,
--   pattern = { "s:n", "i:*" },
--   desc = "Forget the current snippet when leaving the insert mode",
--   callback = function(evt)
--     if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
--       luasnip.unlink_current()
--     end
--   end,
-- })
--

-- vim.api.nvim_create_autocmd("ModeChanged", {
--   pattern = "*",
--   callback = function()
--     if
--       ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
--       and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
--       and not require("luasnip").session.jump_active
--     then
--       require("luasnip").unlink_current()
--     end
--   end,
-- })
--
-- function leave_snippet()
--   if
--     ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
--     and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
--     and not require("luasnip").session.jump_active
--   then
--     require("luasnip").unlink_current()
--   end
-- end
--
-- -- stop snippets when you leave to normal mode
-- vim.api.nvim_command([[
--     autocmd ModeChanged * lua leave_snippet()
-- ]])
