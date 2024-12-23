# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

### First time config ###
# curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin
# ln -s ~/.tmux.conf ~/Dotfiles/tmux/tmux.conf
# ln -s ~/.zshrc ~/Dotfiles/zshrc


### ZSH Config ###
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# if [[ -f "/opt/homebrew/bin/brew" ]] then
#   # If you're using macOS, you'll want this enabled
#   eval "$(/opt/homebrew/bin/brew shellenv)"
# fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
# Remove "zi" alias for default zoxide alias to work
zinit ice atload'unalias zi'

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light https://github.com/Valiev/almostontop

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# set up oh my posh with theme

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'



# source "$<(fzf)"
# eval "$(fzf --zsh)"
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

### Aliases ###
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias fd='fdfind'
alias bc='batcat'
# Git 
alias ga="git add ."
alias gswl="git switch -"
alias gc="git commit -m"
alias gf="git fetch"
alias gp="git push"
alias gpu="git pull"
alias gs="git status"
alias gsv="git status -vvv | bc"
alias gr_v="git remote -v"
alias gitlog_v="git log --graph --decorate --oneline"
alias z.="cd .."
alias z..="cd ../../"
alias z...="cd ../../.."
alias z....="cd ../../../.."
# TODO: fix the following line to jump into directory of a symlink
# alias symdir='$(dirname $(readlinke "$1"))'

# default editors
export VISUAL=vim
export EDITOR="$VISUAL"
export MAKEFLAGS="-j 16"

# fd-find stuff
export FZF_DEFAULT_COMMAND='fdfind --type file --no-hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

# Exa config stuff
alias ls="exa"
alias ll="exa -alh"
alias tree="exa --tree"

# SDL VPN stuff
#alias sdl_vpn=`wsl.exe -d wsl-vpnkit --cd /app service wsl-#vpnkit start`
#export DOCKER_HOST=localhost:2375

### PATH Edits ###
# Add .local
# path=('/home/will/.local/bin' $path)
export PATH=$PATH:/home/will/.local/bin


### oh-my-posh evaluation ###
eval "$(oh-my-posh init zsh --config '/home/will/Dotfiles/ohmyposh/powerlevel10k_rainbow.omp.json')"

### Zoxide ###
# Zoxide Initialization (do not move away from being the last line)
eval "$(zoxide init zsh)"
