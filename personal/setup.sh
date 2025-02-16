#!/bin/bash

# Set the path to your Dotfiles repository
DOTFILES_DIR="$HOME/Dotfiles"  # Change this if your repo is elsewhere

# Define the files and directories to symlink
declare -A LINKS
LINKS["$HOME/.tmux.conf"]="$DOTFILES_DIR/tmux/.tmux.conf"
LINKS["$HOME/.zshrc"]="$DOTFILES_DIR/.zshrc"
LINKS["$HOME/.config/ohmyposh"]="$DOTFILES_DIR/ohmyposh"
LINKS["$HOME/.config/"]
LINKS["$HOME/.config/nvim"]="$DOTFILES_DIR/neovim"

# Function to create symlinks
create_symlinks() {
    for target in "${!LINKS[@]}"; do
        source="${LINKS[$target]}"
        
        # Ensure the source file/directory exists
        if [ ! -e "$source" ]; then
            echo "Source $source does not exist. Skipping..."
            continue
        fi
        
        # Remove existing target if it exists
        if [ -e "$target" ] || [ -L "$target" ]; then
            echo "Removing existing $target"
            rm -rf "$target"
        fi
        
        # Create symlink
        ln -s "$source" "$target"
        echo "Created symlink: $target -> $source"
    done
}

# Run the function
create_symlinks
