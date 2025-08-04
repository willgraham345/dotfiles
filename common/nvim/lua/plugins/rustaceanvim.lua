return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      -- local codelldb_path = vim.fn.stdpath('data') .. '/mason/bin/codelldb'
      -- local liblldb_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib'
      -- local cfg = require('rustaceanvim.config')
      vim.g.rustaceanvim = {
        -- dap = {
        --     adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
        -- },
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              runnables = {
                extraTestBinaryArgs = { "--nocapture" },
              },
            },
          },
        },
      }
    end,
  },
}
