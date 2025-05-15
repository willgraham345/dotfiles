local default_filter_dir = require("neotest.config").discovery.filter_dir
return {
  { "nvim-neotest/neotest-plenary" },
  { "alfaix/neotest-gtest" },
  { "orjangj/neotest-ctest"},
  {
    "mrcjkb/rustaceanvim"
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "alfaix/neotest-gtest",
      "mrcjkb/rustaceanvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/nvim-nio",
      "orjangj/neotest-ctest",
    },
    opts = function(_, opts)
      local utils = require("neotest-gtest.utils")
      local lib = require("neotest.lib")
      -- cpp adapter
      table.insert(
        opts.adapters,
        -- require("rustaceanvim.neotest").setup({}),
        require("neotest-gtest").setup({
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
          -- is_test_file = function(file)
          --   -- by default, returns true if the file stem starts with test_ or ends with _test
          --   -- the extension must be cpp/cppm/cc/cxx/c++
          --   local filename = file:match("([^/\\]+)$") or file
          --   if filename:match("$Test") then
          --     return true
          --   end
          --   return filename:match("^test.+$") ~= nil
          --   -- if string.find(file, "test") then -- Example: Check if "test" is in the file path
          --   --     return true
          --   -- end
          --   -- return false
          --
          -- end,
          is_test_file = function(file)
            -- 1) isolate basename
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
          mappings = {configure = "c"},
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
          
          --FIXME: Not doing test directory finding correctly, handled in the is_test_file() instead
          ---@async
          ---@param name string Name of directory
          ---@param rel_path string Path to directory, relative to root
          ---@param root string Root directory of project
          ---@return boolean
          -- filter_dir = function(name, rel_path, root)
          --   local full_path = root .. "/" .. rel_path
          --
          --   print("full_path")
          --   print(full_path)
          --   if root:match("test") or root:match("tests") then
          --     print("matched dir")
          --     if full_path:match("^unit_tests") then
          --       print("matched dir")
          --       return true
          --   else
          --     print("false dir")
          --     return false
          --     end
          --   else
          --     print("node mods")
          --     return name ~= "node_modules"
          --   end
          -- end
        })
    )
            -- table.insert(
            --   opts.adapters,
            --   require("rustaceanvim.neotest")
    -- FIXME: Not as clean as it once was
    table.insert(
      opts.adapters,
      require("rustaceanvim.neotest")
    )
    if not opts.discovery then
      opts.discovery = {}
    end
    if not opts.running then
      opts.running = {}
    end
    opts.discovery = {
      enabled = false,
      concurrent = 1
    }
    opts.running = {
      concurrent = true
    }

    end,
  },
  -- Tried this, still didn't get any tests to show up
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "alfaix/neotest-gtest",
  --     "mrcjkb/rustaceanvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-neotest/nvim-nio",
  --     "orjangj/neotest-ctest",
  --    },
  --   opts = {
  --     -- Can be a list of adapters like what neotest expects,
  --     -- or a list of adapter names,
  --     -- or a table of adapter names, mapped to adapter configs.
  --     -- The adapter will then be automatically loaded with the config.
  --     adapters = {
  --       ["rustaceanvim.neotest"] = {},
  --       ["neotest-gtest"] = {},
  --       ["neotest-ctest"] = {},
  --     },
  --     -- Example for loading neotest-golang with a custom config
  --     -- adapters = {
  --     --   ["neotest-golang"] = {
  --     --     go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
  --     --     dap_go_enabled = true,
  --     --   },
  --     -- },
  --     status = { virtual_text = true },
  --     output = { open_on_run = true },
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
  --   config = function(_, opts)
  --     local neotest_ns = vim.api.nvim_create_namespace("neotest")
  --     vim.diagnostic.config({
  --       virtual_text = {
  --         format = function(diagnostic)
  --           -- Replace newline and tab characters with space for more compact diagnostics
  --           local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
  --           return message
  --         end,
  --       },
  --     }, neotest_ns)
  --
  --     if LazyVim.has("trouble.nvim") then
  --       opts.consumers = opts.consumers or {}
  --       -- Refresh and auto close trouble after running tests
  --       ---@type neotest.Consumer
  --       opts.consumers.trouble = function(client)
  --         client.listeners.results = function(adapter_id, results, partial)
  --           if partial then
  --             return
  --           end
  --           local tree = assert(client:get_position(nil, { adapter = adapter_id }))
  --
  --           local failed = 0
  --           for pos_id, result in pairs(results) do
  --             if result.status == "failed" and tree:get_key(pos_id) then
  --               failed = failed + 1
  --             end
  --           end
  --           vim.schedule(function()
  --             local trouble = require("trouble")
  --             if trouble.is_open() then
  --               trouble.refresh()
  --               if failed == 0 then
  --                 trouble.close()
  --               end
  --             end
  --           end)
  --           return {}
  --         end
  --       end
  --     end
  --
  --     if opts.adapters then
  --       local adapters = {}
  --       for name, config in pairs(opts.adapters or {}) do
  --         if type(name) == "number" then
  --           if type(config) == "string" then
  --             config = require(config)
  --           end
  --           adapters[#adapters + 1] = config
  --         elseif config ~= false then
  --           local adapter = require(name)
  --           if type(config) == "table" and not vim.tbl_isempty(config) then
  --             local meta = getmetatable(adapter)
  --             if adapter.setup then
  --               adapter.setup(config)
  --             elseif adapter.adapter then
  --               adapter.adapter(config)
  --               adapter = adapter.adapter
  --             elseif meta and meta.__call then
  --               adapter = adapter(config)
  --             else
  --               error("Adapter " .. name .. " does not support setup")
  --             end
  --           end
  --           adapters[#adapters + 1] = adapter
  --         end
  --       end
  --       opts.adapters = adapters
  --     end
  --
  --     require("neotest").setup(opts)
  --   end,
  --   -- stylua: ignore
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
  --   },
  -- },
    
  -- Old neotest setup.
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "alfaix/neotest-gtest",
  --     "mrcjkb/rustaceanvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-neotest/nvim-nio",
  --     "orjangj/neotest-ctest",
  --   },
  --   opts = {
  --     adapters = {
  --       ["rustaceanvim.neotest"] = {},
  --       ["neotest-gtest"] = {},
  --       ["neotest-ctest"] = {
  --         root = lib.files.match_root_pattern(
  --           "compile_commands.json"
  --           "compile_commands.json",
  --           "compile_flags.txt",
  --           "WORKSPACE",
  --           ".clangd",
  --           "init.lua",
  --           "init.vim",
  --           "build",
  --           ".git",
  --           "*Tester",
  --           "bin-test/*"
  --         ),
  --       }
  --       -- ["neotest-ctest"] = require("neotest-ctest").setup({}),
  --     },
  --   },
  -- },
  {
    "SGauvin/ctest-telescope.nvim",
    opts = {
      dap_config = {
        stopAtEntry = true,
        setupCommands = {
          {
            text = "-enable-pretty-printing",
            description = "Enable pretty printing",
            ignoreFailures = false,
          },
        },
      },
    }
  },
}

-- Old tries
-- return {
--   "nvim-neotest/neotest",
--   lazy = false,
--   event = "LspAttach",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     -- "nvim-neotest/nvim-nio",
--     "alfaix/neotest-gtest",
--     "nvim-treesitter/nvim-treesitter",
--     "antoinemadec/FixCursorHold.nvim",
--   },
--   cmds = {
--     "Neotest run",
--   },
--   config = function()
--     local utils = require("neotest-gtest.utils")
--     local lib = require("neotest.lib")
--     -- require("custom.configs.neotest")
--     require("neotest-gtest").setup({
--       -- fun(string) -> string: takes a file path as string and returns its project root
--       -- directory
--       -- neotest.lib.files.match_root_pattern() is a convenient factory for these functions:
--       -- it returns a function that returns true if the directory contains any entries
--       -- with matching names
--       root = lib.files.match_root_pattern(
--         "compile_commands.json",
--         "compile_flags.txt",
--         "WORKSPACE",
--         ".clangd",
--         "init.lua",
--         "init.vim",
--         "build",
--         ".git",
--         "*Tester",
--         "bin-test/*"
--       ),
--       -- which debug adapter to use? dap.adapters.<this debug_adapter> must be defined.
--       debug_adapter = "codelldb",
--       -- fun(string) -> bool: takes a file path as string and returns true if it contains
--       -- tests
--       is_test_file = function(file)
--         -- by default, returns true if the file stem starts with test_ or ends with _test
--         -- the extension must be cpp/cppm/cc/cxx/c++
--       end,
--       -- How many old test results to keep on disk (stored in stdpath('data')/neotest-gtest/runs)
--       history_size = 3,
--       -- To prevent large projects from freezing your computer, there's some throttling
--       -- for -- parsing test files. Decrease if your parsing is slow and you have a
--       -- monster PC.
--       parsing_throttle_ms = 10,
--       -- set configure to a normal mode key which will run :ConfigureGtest (suggested:
--       -- "C", nil by default)
--       mappings = { configure = nil },
--       summary_view = {
--         -- How long should the header be in tests short summary?
--         -- ________TestNamespace.TestName___________ <- this is the header
--         header_length = 80,
--         -- Your shell's colors, if the default ones don't work.
--         shell_palette = {
--           passed = "\27[32m",
--           skipped = "\27[33m",
--           failed = "\27[31m",
--           stop = "\27[0m",
--           bold = "\27[1m",
--         },
--       },
--       -- What extra args should ALWAYS be sent to google test?
--       -- if you want to send them for one given invocation only,
--       -- send them to `neotest.run({extra_args = ...})`
--       -- see :h neotest.RunArgs for details
--       extra_args = {},
--       -- see :h neotest.Config.discovery. Best to keep this as-is and set
--       -- per-project settings in neotest instead.
--       filter_dir = function(name, rel_path, root)
--         -- see :h neotest.Config.discovery for defaults
--       end,
--     })
--   end,
-- }
--
-- -- root = lib.files.match_root_pattern(
-- --   "build/compile_commands.json",
-- --   "*Tester",
-- --   "build/bin-test/*",
-- --   "build/compile_flags.txt",
-- --   "WORKSPACE",
-- --   ".clangd",
-- --   "init.lua",
-- --   "init.vim",
-- --   "build/",
-- --   ".git"
