#!/bin/bash

## File defining symlinks necessary to set up dotfiles in a nice way for Will Graham

# Set the path to your Dotfiles repository
DOTFILES_DIR=$(pwd) # Change this if your repo is elsewhere
DOT_CONFIGS=$(pwd)/dot_config
SUBMODULES_DIR=$(pwd)/submomdules
WORK_DIR=$(pwd)/vars/work
PERSONAL_DIR=$(pwd)/vars/personal

# Define the files and directories to symlink
declare -A LINKS
# LINKS["$HOME/.tmux.conf"]="$DOTFILES_DIR/tmux/.tmux.conf"
if [[ "$1" == "--common" ]]; then
  MODE="shell"
  LINKS["$HOME/.config/ohmyposh"]="$DOT_CONFIGS/ohmyposh"
  LINKS["$HOME/.config/tmux"]="$DOT_CONFIGS/tmux" # Doesn't take care of of the plugins stuff, needs additional link
  LINKS["$HOME/.tmux"]="$SUBMODULES_DIR/tmux" # Takes care of the plugins stuff
  LINKS["$HOME/.config/nvim"]="$DOT_CONFIGS/nvim"
  LINKS["$HOME/.config/lazygit"]="$DOT_CONFIGS/lazygit"
  LINKS["$HOME/.config/lazydocker"]="$DOT_CONFIGS/lazygit"
  LINKS["$HOME/.gdbinit"]="$DOTFILES_DIR/.gdbinit"
  LINKS["$HOME/.config/.gdbinit"]="$DOTFILES_DIR/.gdbinit"
  LINKS["$HOME/.rgrc"]="$DOT_CONFIGS/ripgrep/.rgrc"
  LINKS["$HOME/.config/.delta-themes.gitconfig"]="$DOTFILES_DIR/.delta-themes.gitconfig"
  LINKS["$HOME/.config/navi"]="$DOT_CONFIGS/navi"
  LINKS["$HOME/.config/yazi"]="$DOT_CONFIGS/yazi"
fi

if [[ "$1" == "--work" ]]; then
  MODE="work"
  LINKS["$HOME/.gitconfig"]="$WORK_DIR/.gitconfig"
  LINKS["$HOME/.zshrc"]="$WORK_DIR/.zshrc"
  LINKS["$HOME/.gitignore-excludesfile"]="$WORK_DIR/.gitignore-excludesfile"
  
  # Creates symlink to wsl.conf
  if [[ "$2" == --wsl-cfg ]]; then
    LINKS["/etc/wsl.conf"]="$WORK_DIR/wsl.conf"
  fi
fi

if [[ "$1" == "--personal" ]]; then
  MODE="work"
  LINKS["$HOME/.gitconfig"]="$PERSONAL_DIR/.gitconfig"
  LINKS["$HOME/.zshrc"]="$PERSONAL_DIR/.zshrc"
  
  # Creates symlink to wsl.conf
  if [[ "$2" == --wsl-cfg ]]; then
    LINKS["/etc/wsl.conf"]="$PERSONAL_DIR/wsl.conf"
  fi
fi


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
