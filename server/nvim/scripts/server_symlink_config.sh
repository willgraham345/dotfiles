#!/bin/bash

COMMON_NVIM_DIR="../../../common/nvim"

PLUGINS_TO_LINK=(
  "init.lua"
  "lua/plugins/lspconfig.lua"
  "lua/plugins/treesitter.lua"
  "lua/general.lua"
  "lua/plugins/autolist.lua"
  "lua/plugins/chart.lua"
  "lua/plugins/cmp.lua"
  "lua/plugins/colorscheme.lua"
  "lua/plugins/comments.lua"
  "lua/plugins/compiler.lua"
  "lua/plugins/conform.lua"
  "lua/plugins/disabled.lua"
  "lua/plugins/docs-view.lua"
  "lua/plugins/editor.lua"
  "lua/plugins/git_plugins.lua"
  "lua/plugins/goto-preview.lua"
  "lua/plugins/lsp.lua"
  "lua/plugins/markdown-preview.lua"
  "lua/plugins/mason-workaround.lua"
  "lua/plugins/nvim-window.lua"
  "lua/plugins/quickfix.lua"
  "lua/plugins/schema.lua"
  "lua/plugins/snippets.lua"
  "lua/plugins/symbol-usage.lua"
  "lua/plugins/symbols.lua"
  "lua/plugins/ui.lua"
  "lua/plugins/util.lua"
  "lua/plugins/venv-selector.lua"
  "lua/plugins/vim-visual-multi.lua"
  "lua/config/autocmds.lua"
  "lua/config/keymaps.lua"
  "lua/config/lazy.lua"
  "lua/config/options.lua"
)

echo "--- Starting Neovim Plugin Symlink Management ---"
echo "Script launched from: $(pwd)"
echo "Common Neovim directory (relative): $COMMON_NVIM_DIR"

DEST_BASE_DIR="../"

if [ ! -d "$COMMON_NVIM_DIR" ]; then
    echo "Error: Common Neovim directory not found at '$COMMON_NVIM_DIR'."
    exit 1
fi

echo "--- Cleaning up ALL existing symlinks in '$DEST_BASE_DIR' (excluding this script's directory) ---"
find "$DEST_BASE_DIR" -maxdepth 5 -type l -not -path "$DEST_BASE_DIRscripts/*" -delete
echo "--- Cleanup complete ---"

echo "--- Creating new symlinks ---"
for plugin_path in "${PLUGINS_TO_LINK[@]}"; do
    SOURCE_PATH="$COMMON_NVIM_DIR/$plugin_path"
    DEST_PATH="$DEST_BASE_DIR/$plugin_path"

    DEST_DIR=$(dirname "$DEST_PATH")

    if [ ! -d "$DEST_DIR" ]; then
        mkdir -p "$DEST_DIR"
    fi

    if [ ! -e "$SOURCE_PATH" ]; then
        echo "Warning: Source '$SOURCE_PATH' does not exist. Skipping link."
        continue
    fi

    echo "Linking '$SOURCE_PATH' to '$DEST_PATH'"
    ln -sfv "$SOURCE_PATH" "$DEST_PATH"
done

echo "--- Symlink Management Complete ---"
echo "Remember to re-open Neovim to apply changes."
