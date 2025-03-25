return {
  --- See https://www.arthurkoziel.com/json-schemas-in-neovim/ for more info on how this works
  "someone-stole-my-name/yaml-companion.nvim",
  requires = {
    { "neovim/nvim-lspconfig" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    local cfg = require("yaml-companion").setup({
      -- Additional schemas available in Telescope picker
      schemas = {
        {
          name = "Flux GitRepository",
          uri = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/gitrepository-source-v1.json",
        },
        {
          name = "Lazy docker",
          uri = "https://json.schemastore.org/lazydocker.json",
        },
        {
          name = "Docker sequencer",
          uri = "https://gitlab.com/sbenv/veroxis/docker-seq/-/raw/HEAD/docker-seq.schema.json",
        },
        {
          name = "Dockerd",
          uri = "https://json.schemastore.org/dockerd.json",
        },
      },

      -- Pass any additional options that will be merged in the final LSP config
      -- Defaults: https://github.com/someone-stole-my-name/yaml-companion.nvim/blob/main/lua/yaml-companion/config.lua
      -- See additional schemas at https://github.com/SchemaStore/schemastore/blob/master/src/api/json/catalog.json
      lspconfig = {
        settings = {
          yaml = {
            validate = true,
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*compose*{yml,yaml}",
            },
          },
        },
      },
    })

    require("lspconfig")["yamlls"].setup(cfg)

    -- :Telescope yaml_schema
    require("telescope").load_extension("yaml_schema")
  end,
}
