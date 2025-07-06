vim.g.lazyvim_rust_diagnostics = "bacon-ls"
local diagnostics = vim.g.lazyvim_rust_diagnostics
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "simrat39/rust-tools.nvim",
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { window = { size = "90%" }, lsp = { auto_attach = true } },
      },
    },
    opts = {
      inlay_hints = {
        enabled = true,
      },
      diagnostics = {
        virtual_text = false,
        signs = false,
      },
      servers = {
        bacon_ls = {
          enabled = diagnostics == "bacon-ls",
        },
        lua_ls = {},
        neocmake = {},
        pyright = {},
        rust_analyzer = { enabled = false },
      },
      clangd = {
        keys = {
          { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            "Makefile",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja"
          )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
            fname
          ) or require("lspconfig.util").find_git_ancestor(fname)
        end,
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- TODO: Add logic for global flags on langauges to install
      vim.list_extend(opts.ensure_installed, { "codelldb" })
      vim.list_extend(opts.ensure_installed, { "cmakelang", "cmakelint" })
      vim.list_extend(opts.ensure_installed, { "pyright", "black", "debugpy" })
      vim.list_extend(opts.ensure_installed, { "stylua" })
      if diagnostics == "bacon-ls" then
        vim.list_extend(opts.ensure_installed, { "bacon" })
      end
      PATH = "append" -- This makes mason defualt to locally installed packages
    end,
  },
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
        "cpp",
        "cmake",
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
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { "markdown_inline" } },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 3000,
      },
    },
  },
}
