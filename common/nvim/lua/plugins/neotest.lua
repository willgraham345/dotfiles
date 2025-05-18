local lib = require("neotest.lib")
local gtest_config = {
      root = lib.files.match_root_pattern(
        "build/compile_commands.json",
        "compile_commands.json",
        "compile_flags.txt",
        "WORKSPACE",
        ".clangd",
        "init.lua",
        "init.vim",
        "build",
        ".git"
                ),
      debug_adapter = "codelldb",
      -- fun(string) -> bool: takes a file path as string and returns true if it contains
      -- tests
      is_test_file = function(file)
        -- 1) isolate basename
        -- print("scanning files...") -- left for debugging...
        if string.find(file, "test") then
          --or make it fall back to the orignal path if there isn't a "/" in the string
          file:gsub(".+/", "")
          if string.find(file, "test_")  or string.find(file, "Test.cpp") or string.find(file, "test") then
            return true
            -- return string.match(file, "test/") or string.match(file, "tests/")
          end
        end
        return false
      end,
      history_size = 3,
      parsing_throttle_ms = 10,
      mappings = {configure = nil},
      summary_view = {
        header_length = 80,
        shell_palette = {
          passed = "\27[32m",
          skipped = "\27[33m",
          failed = "\27[31m",
          stop = "\27[0m",
          bold = "\27[1m",
        },
      },
      extra_args = {},
}
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "alfaix/neotest-gtest",
      "mrcjkb/rustaceanvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/nvim-nio",
      "alfaix/neotest-gtest"
     },
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      discovery = {
        enabled = false,
        concurrent = 1
      },
      running = {
        concurrent = false
      },
      quickfix = {
        open = function()
          if LazyVim.has("trouble.nvim") then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,
      },
    },

    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      if LazyVim.has("trouble.nvim") then
        opts.consumers = opts.consumers or {}
        -- Refresh and auto close trouble after running tests
        ---@type neotest.Consumer
        opts.consumers.trouble = function(client)
          client.listeners.results = function(adapter_id, results, partial)
            if partial then
              return
            end
            local tree = assert(client:get_position(nil, { adapter = adapter_id }))

            local failed = 0
            for pos_id, result in pairs(results) do
              if result.status == "failed" and tree:get_key(pos_id) then
                failed = failed + 1
              end
            end
            vim.schedule(function()
              local trouble = require("trouble")
              if trouble.is_open() then
                trouble.refresh()
                if failed == 0 then
                  trouble.close()
                end
              end
            end)
            return {}
          end
        end
      end

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                print("starting adapter setup" .. name)
                adapter.setup(config)
              elseif adapter.adapter then
                adapter.adapter(config)
                adapter = adapter.adapter
              elseif meta and meta.__call then
                adapter = adapter(config)
              else
                print("Adapter" .. name .. " does not support setup")
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end
      table.insert(
          opts.adapters,
          require("neotest-gtest").setup(gtest_config)
        )
      require("neotest").setup(opts)
    end,
  },
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "alfaix/neotest-gtest",
  --     "mrcjkb/rustaceanvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-neotest/nvim-nio",
  --     "alfaix/neotest-gtest"
  --    },
  --   opts = {
  --     -- Can be a list of adapters like what neotest expects,
  --     -- or a list of adapter names,
  --     -- or a table of adapter names, mapped to adapter configs.
  --     -- The adapter will then be automatically loaded with the config.
  --     adapters = {
  --       ["rustaceanvim.neotest"] = {},
  --       ["neotest-gtest"] = {}
  --     },
  --     status = { virtual_text = true },
  --     output = { open_on_run = true },
  --     discovery = {
  --       enabled = false,
  --       concurrent = 1
  --     },
  --     running = {
  --       concurrent = false
  --     },
  --     quickfix = {
  --       open = function()
  --         if LazyVim.has("trouble.nvim") then
  --           require("trouble").open({ mode = "quickfix", focus = false })
  --         else
  --           vim.cmd("copen")
  --         end
  --       end,
  --     },
  --   },
  --
  --   config = function(_, opts)
  --   local neotest_ns = vim.api.nvim_create_namespace("neotest")
  --   vim.diagnostic.config({
  --     virtual_text = {
  --       format = function(diagnostic)
  --         -- Replace newline and tab characters with space for more compact diagnostics
  --         local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
  --         return message
  --       end,
  --     },
  --   }, neotest_ns)
  --
  --   if LazyVim.has("trouble.nvim") then
  --     opts.consumers = opts.consumers or {}
  --     -- Refresh and auto close trouble after running tests
  --     ---@type neotest.Consumer
  --     opts.consumers.trouble = function(client)
  --       client.listeners.results = function(adapter_id, results, partial)
  --         if partial then
  --           return
  --         end
  --         local tree = assert(client:get_position(nil, { adapter = adapter_id }))
  --
  --         local failed = 0
  --         for pos_id, result in pairs(results) do
  --           if result.status == "failed" and tree:get_key(pos_id) then
  --             failed = failed + 1
  --           end
  --         end
  --         vim.schedule(function()
  --           local trouble = require("trouble")
  --           if trouble.is_open() then
  --             trouble.refresh()
  --             if failed == 0 then
  --               trouble.close()
  --             end
  --           end
  --         end)
  --         return {}
  --       end
  --     end
  --   end
  --
  --   if opts.adapters then
  --     local adapters = {}
  --     for name, config in pairs(opts.adapters or {}) do
  --       if type(name) == "number" then
  --         if type(config) == "string" then
  --           config = require(config)
  --         end
  --         adapters[#adapters + 1] = config
  --       elseif config ~= false then
  --         local adapter = require(name)
  --         if type(config) == "table" and not vim.tbl_isempty(config) then
  --           local meta = getmetatable(adapter)
  --           if adapter.setup then
  --             adapter.setup(config)
  --           elseif adapter.adapter then
  --             adapter.adapter(config)
  --             adapter = adapter.adapter
  --           elseif meta and meta.__call then
  --             adapter = adapter(config)
  --           else
  --             print("Adapter" .. name .. " does not support setup")
  --             error("Adapter " .. name .. " does not support setup")
  --           end
  --         end
  --         adapters[#adapters + 1] = adapter
  --       end
  --     end
  --     opts.adapters = adapters
  --   end
  --
  --   require("neotest").setup(opts)
  -- end,
  -- -- stylua: ignore
  --   keys = {
  --     {"<leader>t", "", desc = "+test"},
  --     { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
  --     { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
  --     { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
  --     { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
  --     { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
  --     { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
  --     { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
  --     { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
  --     { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
  --   }
  -- },
  -- {
  --   "SGauvin/ctest-telescope.nvim",
  --   opts = {
  --     dap_config = {
  --       stopAtEntry = true,
  --       setupCommands = {
  --         {
  --           text = "-enable-pretty-printing",
  --           description = "Enable pretty printing",
  --           ignoreFailures = false,
  --         },
  --       },
  --     },
  --   }
  -- },
}

