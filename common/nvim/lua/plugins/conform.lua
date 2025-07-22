return {
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    opts = function()
      -- local plugin = require("lazy.core.config").plugins["conform.nvim"]
      -- if plugin.config ~= M.setup then
      --   LazyVim.error({
      --     "Don't set `plugin.config` for `conform.nvim`.\n",
      --     "This will break **LazyVim** formatting.\n",
      --     "Please refer to the docs at https://www.lazyvim.org/plugins/formatting",
      --   }, { title = "LazyVim" })
      -- end
      local opts = {

        formatters_by_ft = {
          ["html"] = { "prettier" },
          -- ["markdown"] = { "mdslw", "markdownlint", "mdformat" }, --Kept around jsut in case we need markdown formatting again
          ["markdown"] = { "prettier" },
          ["lua"] = { "stylua" },
          ["python"] = { "isort", "black" },
          ["rust"] = { "rustfmt" },
          ["cpp"] = { "clang_format" },
          ["json"] = { "prettier" },
        },
        formatters = {
          injected = { options = { ignore_errors = true } },
        },
      }
      return opts
    end,
  },
}
