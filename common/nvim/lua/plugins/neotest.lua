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
      if string.find(file, "test_") or string.find(file, "Test.cpp") or string.find(file, "test") then
        return true
        -- return string.match(file, "test/") or string.match(file, "tests/")
      end
    end
    return false
  end,
  history_size = 3,
  parsing_throttle_ms = 50,
  mappings = { configure = nil },
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
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
        ["neotest-python"] = {
          runner = "pytest",
          python = function()
            -- Check for poetry
            local poetry_path = vim.fn.trim(vim.fn.system("poetry env info -p"))
            if vim.v.shell_error == 0 then
              return poetry_path .. "/bin/python"
            end
            -- Fallback for other venvs.
            -- If you use `uv`, you might need a different command to find the python executable.
            -- Returning nil lets neotest-python try to find it automatically.
            return nil
          end,
        },
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      discovery = {
        enabled = false,
        concurrent = 1,
      },
      running = {
        concurrent = true,
      },
      summary = {
        animated = false,
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
      if
        not vim.tbl_isempty(vim.fn.glob("**/*.cpp", true, true))
        or not vim.tbl_isempty(vim.fn.glob("**/*.hpp", true, true))
      then
        table.insert(opts.adapters, require("neotest-gtest").setup(gtest_config))
      end
      require("neotest").setup(opts)
    end,
  },
}
