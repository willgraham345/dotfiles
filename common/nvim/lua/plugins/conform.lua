return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["html"] = { "prettier" },
        -- ["markdown"] = { "mdslw", "markdownlint", "mdformat" },
        ["markdown"] = { "prettier" },
      },
    },
  },
}

--  Michael edits, broke Lazyvim config
-- config = function()
--   require("conform").setup({
--     -- log_level = vim.log.levels.DEBUG,
--     -- Conform will run multiple formatters sequentially
--     -- Use a sub-list to run only the first available formatter
--     formatters_by_ft = {
--       -- Build tools
--       cmake = { "cmake_format" },
--       -- Programming
--       c = { "uncrustify", "clang-format" },
--       cpp = { "uncrustify", "clang-format" },
--       cs = { "uncrustify", "clang-format" },
--       cuda = { "clang-format" },
--       gdscript = { "gdformat" },
--       java = { "uncrustify", "clang-format" },
--       proto = { "clang-format" },
--       rust = { "rustfmt" },
--       zig = { "zigfmt" },
--       -- Scripting
--       lua = { "stylua" },
--       python = { "isort", "black" },
--       -- Data
--       sql = { "sqlfluff" },
--       -- Shell
--       fish = { "fish_indent" },
--       sh = { "beautysh", "shellharden" },
--       zsh = { "beautysh", "shellharden" },
--       -- Web
--       javascript = { "biome", "prettier" },
--       typescript = { "biome", "prettier" },
--       javascriptreact = { "biome", { "prettier" } },
--       typescriptreact = { "biome", "prettier" },
--       json = { "biome", "prettier" },
--       jsonc = { "biome", "prettier" },
--       scss = { "stylelint" },
--       less = { "stylelint" },
--       css = { "stylelint" },
--       sass = { "stylelint" },
--       xml = { "xmllint", "xmlformat" },
--       xsd = { "xmllint", "xmlformat" },
--       -- Config Files
--       toml = { "taplo" },
--       yaml = { "yamlfix", "yamlfmt" },
--       -- Writing
--       markdown = { "mdslw", "markdownlint", "mdformat" },
--     },
--     -- Set up format-on-save
--     -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
--     -- Customize formatters
--     formatters = {
--       ["clang-format"] = {
--         cwd = require("conform.util").root_file({ ".editorconfig", ".git", ".clang-format" }),
--       },
--       shfmt = {
--         prepend_args = { "-i", "2" },
--       },
--       uncrustify = {
--         env = {
--           UNCRUSTIFY_CONFIG = vim.fn.expand("~") .. "/.githooks/config/precommit/uncrustify.cfg",
--         },
--       },
--       cmake_format = {
--         args = {
--           "-c=" .. vim.fn.expand("~") .. "/.githooks/config/precommit/cmake-format.yaml",
--         },
--       },
--       gdformat = {
--         args = {
--           "--use-spaces=2",
--           "-",
--         },
--       },
--     },
--   })
-- end,
-- init = function()
--   -- If you want the formatexpr, here is the place to set it
--   vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
-- end,
