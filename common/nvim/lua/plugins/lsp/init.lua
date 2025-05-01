return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "simrat39/rust-tools.nvim"
    },
    opts = {
      inlay_hints = {
        enabled = true
      },
      diagnostics = {
        virtual_text = false,
        signs = false
      },
      servers = {
        pyright = {},
        bacon_ls = {
          enabled = diagnostics == "bacon-ls",
        },
        rust_analyzer = {},
      },
      setup = {
        rust_analyzer = function(_, opts)
          require("rust-tools").setup({ server = opts })
          return true
        end,
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "codelldb" })
      if diagnostics == "bacon-ls" then
        vim.list_extend(opts.ensure_installed, { "bacon" })
      end
    end
  },

  -- {
  -- "mrcjkb/rustaceanvim",
  --   opts = {
  --     server = {
  --       on_attach = function(_, bufnr)
  --         vim.keymap.set("n", "<leader>cR", function()
  --           vim.cmd.RustLsp("codeAction")
  --         end, { desc = "Code Action", buffer = bufnr })
  --         vim.keymap.set("n", "<leader>dr", function()
  --           vim.cmd.RustLsp("debuggables")
  --         end, { desc = "Rust Debuggables", buffer = bufnr })
  --       end,
  --       default_settings = {
  --         -- rust-analyzer language server configuration
  --         ["rust-analyzer"] = {
  --           cargo = {
  --             allFeatures = true,
  --             loadOutDirsFromCheck = true,
  --             buildScripts = {
  --               enable = true,
  --             },
  --           },
  --           -- Add clippy lints for Rust if using rust-analyzer
  --           checkOnSave = diagnostics == "rust-analyzer",
  --           -- Enable diagnostics if using rust-analyzer
  --           diagnostics = {
  --             enable = diagnostics == "rust-analyzer",
  --           },
  --           procMacro = {
  --             enable = true,
  --             ignored = {
  --               ["async-trait"] = { "async_trait" },
  --               ["napi-derive"] = { "napi" },
  --               ["async-recursion"] = { "async_recursion" },
  --             },
  --           },
  --           files = {
  --             excludeDirs = {
  --               ".direnv",
  --               ".git",
  --               ".github",
  --               ".gitlab",
  --               "bin",
  --               "node_modules",
  --               "target",
  --               "venv",
  --               ".venv",
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- -- config = function(_, opts)
  -- --   if LazyVim.has("mason.nvim") then
  -- --     local package_path = require("mason-registry").get_package("codelldb"):get_install_path()
  -- --     local codelldb = package_path .. "/extension/adapter/codelldb"
  -- --     local library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
  -- --     local uname = io.popen("uname"):read("*l")
  -- --     if uname == "Linux" then
  -- --       library_path = package_path .. "/extension/lldb/lib/liblldb.so"
  -- --     end
  -- --     opts.dap = {
  -- --       adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
  -- --     }
  -- --   end
  -- --   vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
  -- --   if vim.fn.executable("rust-analyzer") == 0 then
  -- --     LazyVim.error(
  -- --       "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
  -- --       { title = "rustaceanvim" }
  -- --     )
  -- --   end
  -- -- end,
  -- },

  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      auto_install = true,
      highlight = {
          enable = true,
          additional_vim_regex_highlighting=false,
        },
      ident = {enable = true},
      rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = 3000,
      }
    }
  },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = true
    },
    -- event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select a venv", noremap = true } },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>", { desc = "Select a cached venv", noremap = true } },
    },
  },
}

-- return {
--   {
--     "simrat39/symbols-outline.nvim",
--     opts = function(_, opts)
--       table.insert(opts.sources, {
--         symbol_folding = {
--           autofold_depth = 1,
--           auto_unfold = {
--             hovered = true,
--             only = 2,
--           },
--         },
--       })
--     end,
--   },
-- }
--{
