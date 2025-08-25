return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    -- config = function()
    --   local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
    --   local liblldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
    --   local cfg = require("rustaceanvim.config")
    --   vim.g.rustaceanvim = {
    --     dap = {
    --       adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    --     },
    --     server = {
    --       default_settings = {
    --         ["rust-analyzer"] = {
    --           runnables = {
    --             extraTestBinaryArgs = { "--nocapture" },
    --           },
    --         },
    --       },
    --     },
    --   }
    -- end,
    opts = {
      server = {
        -- TODO: Look more into if I need to add the "extraTestBinaryArgs" thing listed above. I'm not sure if the lazyvim configuration handles this nicely, or if that's still an issue with the debgger.
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust if using rust-analyzer
            checkOnSave = diagnostics == "rust-analyzer",
            -- Enable diagnostics if using rust-analyzer
            diagnostics = {
              enable = diagnostics == "rust-analyzer",
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      },
    },
  },
}
