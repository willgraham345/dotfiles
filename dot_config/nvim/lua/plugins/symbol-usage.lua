-- local SymbolKind = vim.lsp.protocol.SymbolKind
local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

-- hl-groups can have any name
vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = h('CursorLine').bg, italic = true })
vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg = h('CursorLine').bg, fg = h('Comment').fg, italic = true })
vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = h('Function').fg, bg = h('CursorLine').bg, italic = true })
vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg = h('Type').fg, bg = h('CursorLine').bg, italic = true })
vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg = h('@keyword').fg, bg = h('CursorLine').bg, italic = true })

-- Textformat for bubbles
-- local function text_format(symbol)
--   local res = {}
--
--   local round_start = { '', 'SymbolUsageRounding' }
--   local round_end = { '', 'SymbolUsageRounding' }
--
--   -- Indicator that shows if there are any other symbols in the same line
--   local stacked_functions_content = symbol.stacked_count > 0
--       and ("+%s"):format(symbol.stacked_count)
--       or ''
--
--   if symbol.references then
--     local usage = symbol.references <= 1 and 'usage' or 'usages'
--     local num = symbol.references == 0 and 'no' or symbol.references
--     table.insert(res, round_start)
--     table.insert(res, { '󰌹 ', 'SymbolUsageRef' })
--     table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageContent' })
--     table.insert(res, round_end)
--   end
--
--   if symbol.definition then
--     if #res > 0 then
--       table.insert(res, { ' ', 'NonText' })
--     end
--     table.insert(res, round_start)
--     table.insert(res, { '󰳽 ', 'SymbolUsageDef' })
--     table.insert(res, { symbol.definition .. ' defs', 'SymbolUsageContent' })
--     table.insert(res, round_end)
--   end
--
--   if symbol.implementation then
--     if #res > 0 then
--       table.insert(res, { ' ', 'NonText' })
--     end
--     table.insert(res, round_start)
--     table.insert(res, { '󰡱 ', 'SymbolUsageImpl' })
--     table.insert(res, { symbol.implementation .. ' impls', 'SymbolUsageContent' })
--     table.insert(res, round_end)
--   end
--
--   if stacked_functions_content ~= '' then
--     if #res > 0 then
--       table.insert(res, { ' ', 'NonText' })
--     end
--     table.insert(res, round_start)
--     table.insert(res, { ' ', 'SymbolUsageImpl' })
--     table.insert(res, { stacked_functions_content, 'SymbolUsageContent' })
--     table.insert(res, round_end)
--   end
--
--   return res
-- end
local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

vim.api.nvim_set_hl(0, 'SymbolUsageRef', { bg = h('Type').fg, fg = h('Normal').bg, bold = true })
vim.api.nvim_set_hl(0, 'SymbolUsageRefRound', { fg = h('Type').fg })

vim.api.nvim_set_hl(0, 'SymbolUsageDef', { bg = h('Function').fg, fg = h('Normal').bg, bold = true })
vim.api.nvim_set_hl(0, 'SymbolUsageDefRound', { fg = h('Function').fg })

vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { bg = h('@parameter').fg, fg = h('Normal').bg, bold = true })
vim.api.nvim_set_hl(0, 'SymbolUsageImplRound', { fg = h('@parameter').fg })

local function text_format(symbol)
  local res = {}

  -- Indicator that shows if there are any other symbols in the same line
  local stacked_functions_content = symbol.stacked_count > 0
      and ("+%s"):format(symbol.stacked_count)
      or ''

  if symbol.references then
    table.insert(res, { '󰍞', 'SymbolUsageRefRound' })
    table.insert(res, { '󰌹 ' .. tostring(symbol.references), 'SymbolUsageRef' })
    table.insert(res, { '󰍟', 'SymbolUsageRefRound' })
  end

  if symbol.definition then
    if #res > 0 then
      table.insert(res, { ' ', 'NonText' })
    end
    table.insert(res, { '󰍞', 'SymbolUsageDefRound' })
    table.insert(res, { '󰳽 ' .. tostring(symbol.definition), 'SymbolUsageDef' })
    table.insert(res, { '󰍟', 'SymbolUsageDefRound' })
  end

  if symbol.implementation then
    if #res > 0 then
      table.insert(res, { ' ', 'NonText' })
    end
    table.insert(res, { '󰍞', 'SymbolUsageImplRound' })
    table.insert(res, { '󰡱 ' .. tostring(symbol.implementation), 'SymbolUsageImpl' })
    table.insert(res, { '󰍟', 'SymbolUsageImplRound' })
  end

  if stacked_functions_content ~= '' then
    if #res > 0 then
      table.insert(res, { ' ', 'NonText' })
    end
    table.insert(res, { '󰍞', 'SymbolUsageImplRound' })
    table.insert(res, { ' ' .. tostring(stacked_functions_content), 'SymbolUsageImpl' })
    table.insert(res, { '󰍟', 'SymbolUsageImplRound' })
  end

  return res
end

return {
  {
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require('symbol-usage').setup({
        text_format = text_format,
      })
      require('symbol-usage').toggle_globally() -- Turns it off globally to start
    end
  }
  -- {
  --   'VidocqH/lsp-lens.nvim',
  --   config = function ()
  --     require'lsp-lens'.setup({
  --       enable = true,
  --       include_declaration = false,      -- Reference include declaration
  --       sections = {                      -- Enable / Disable specific request, formatter example looks 'Format Requests'
  --         definition = false,
  --         references = true,
  --         implements = true,
  --         git_authors = true,
  --       },
  --       ignore_filetype = {
  --         "prisma",
  --       },
  --       -- Target Symbol Kinds to show lens information
  --       target_symbol_kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface },
  --       -- Symbol Kinds that may have target symbol kinds as children
  --       wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
  --
  --     })
  --   end
  -- }
}
