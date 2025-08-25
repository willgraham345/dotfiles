return {
    "nvim-treesitter/nvim-treesitter",
    version = false,

    opts = {
        highlight = { enable = true , additional_vim_regex_highlighting = { "markdown" } },
        indent = { enable = true, disable = {"markdown"}, }, -- Disable is necessary to remove the weird indenting that happens in markdown_inline and markdown
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
        incremental_selection = {
            enable = true,
            keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
            },
        },
        textobjects = {
            move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
            },
        },
    }
}
