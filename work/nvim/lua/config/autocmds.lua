-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

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
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    if
      ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})

function leave_snippet()
  if
    ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
    and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
    and not require("luasnip").session.jump_active
  then
    require("luasnip").unlink_current()
  end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_command([[
    autocmd ModeChanged * lua leave_snippet()
]])
