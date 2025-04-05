#!/bin/bash

# Set the path to your Dotfiles repository
DOTFILES_DIR=$(pwd) # Change this if your repo is elsewhere

# Define the files and directories to symlink
declare -A LINKS
# LINKS["$HOME/.tmux.conf"]="$DOTFILES_DIR/tmux/.tmux.conf"
LINKS["$HOME/.zshrc"]="$DOTFILES_DIR/.zshrc"
LINKS["$HOME/.config/ohmyposh"]="$DOTFILES_DIR/ohmyposh"
LINKS["$HOME/.config/tmux"]="$DOTFILES_DIR/tmux"
LINKS["$HOME/.config/nvim"]="$DOTFILES_DIR/nvim"
LINKS["$HOME/.config/lazygit"]="$DOTFILES_DIR/lazygit"
LINKS["$HOME/.config/lazydocker"]="$DOTFILES_DIR/lazygit"
LINKS["$HOME/.gitconfig"]="$DOTFILES_DIR/.gitconfig"
LINKS["$HOME/.gitignore"]="$DOTFILES_DIR/.gitignore"
LINKS["$HOME/.gdbinit"]="$DOTFILES_DIR/.gdbinit"
LINKS["$HOME/.config/.gdbinit"]="$DOTFILES_DIR/.gdbinit"

# Function to create symlinks
create_symlinks() {
	for target in "${!LINKS[@]}"; do
		source="${LINKS[$target]}"

		# Ensure the source file/directory exists
		if [ ! -e "$source" ]; then
			echo "ERROR: Source $source not found. Skipping..."
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

# Check for these directories, create them if not there
dirs=("$HOME/.local/bin" "$HOME/.local/share" "$HOME/.local/state")
for dir in "${dirs[@]}"; do
	if [ ! -d "$dir" ]; then
		echo "Creating directory: $dir"
		mkdir -p "$dir"
	else
		echo "Directory already exists: $dir"
	fi
done
