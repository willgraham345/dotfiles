function SaveLspDefintion()
  local fzf = require("fzf-lua")
  local defs = require("fzf-lua.providers.lsp").definitions ---@type fun(opts: fzf-lua.config.LspDefinitions.p?): thread?, string?, table?
  defs(opts)

  -- fzf.fzf_exec()
  fzf.lsp_definitions({
    winopts = {
      preview = {
        hidden = true,
      },
    },
    actions = {
      ["ctrl-y"] = function(selected)
        local filename = selected[1]
        local content = vim.fn.readfile(filename)
        vim.fn.setreg("+", content)
        vim.notify("Lsp definition saved to clipboard!", vim.log.levels.INFO)
      end,
    },
  })
end

vim.keymap.set("n", "<leader>vd", SaveLspDefintion, { desc = "Save lsp definition" })
