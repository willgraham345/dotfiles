return {
  "stevearc/overseer.nvim",
  opts = {
    tasks = {
      {
        name = "CMake Configure",
        builder = function()
          return {
            cmd = { "cmake" },
            args = { "-B", "build", "-G", "Ninja", "-Wno-dev" },
            components = { "default" },
          }
        end,
        condition = {
          callback = function()
            return vim.fn.filereadable("CMakeLists.txt") == 1
          end,
        },
      },
      {
        name = "CMake Build",
        builder = function()
          return {
            cmd = { "cmake" },
            args = { "--build", "build" },
            components = { "default" },
          }
        end,
        condition = {
          callback = function()
            return vim.fn.isdirectory("build") == 1
          end,
        },
      },
    },
  },
}
