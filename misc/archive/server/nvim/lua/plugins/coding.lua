return {
  {
    "echasnovski/mini.pairs",
    opts = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts or {}, {
        mappings = {
          ['"'] = false, -- Disable auto-pairing for double quotes
        },
      })
      return opts
    end,
  },
}
