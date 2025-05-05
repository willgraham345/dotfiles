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
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found
zinit snippet OMZP::git
zinit snippet OMZP::colored-man-pages
# Load completions
autoload -Uz compinit && compinit
autoload -U colors && colors

zinit cdreplay -q

# set up oh my posh with theme

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' backward-kill-word

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
zstyle ':completion::complete:make:*:targets' call-command true
export WORDCHARS='*?.[]~=&;!#$%^(){}<>' #default: WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'

# source "$<(fzf)"
# eval "$(fzf --zsh)"
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

### Aliases ###
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias fd='fdfind'
alias cat='batcat'
# Git 
alias ga="git add ."
alias gswl="git switch -"
alias gc="git commit -m"
alias gf="git commit --fixup=HEAD"
alias gp="git push"
alias gpu="git pull"
alias gs="git status"
alias gsv="git status -vvv | bc"
alias gr_v="git remote -v"
alias gitlog_v="git log --graph --decorate --oneline"
# Docker
alias drc='docker ps -qa' 
alias drv='docker volume ls -q'
alias de='docker exec -it'
alias dps='docker ps --all'
alias dclall='docker rm $(docker ps -qa) && docker volume rm $(docker volume ls -q)'
alias dclv='docker volume rm $(docker volume ls -q)'
alias dcln='docker network rm $(docker network ls -q)'
alias dclc='docker rm $(docker ps -qa)'
dc(){
  docker compose -f "$1" "$2"
}
dcbu(){
  docker compose -f "$1" build
}
dcu() {
  docker compose -f "$1" up -d
}
dcu_v() {
  docker compose -f "$1" up
}
dcd() {
  docker compose -f "$1" down
}
d2preview(){
  d2 --watch --browser=0 "$1".d2 "$1".svg
}
alias z.="cd .."
alias z..="cd ../../"
alias z...="cd ../../.."
alias z....="cd ../../../.."
# TODO: fix the following line to jump into directory of a symlink
# alias symdir='$(dirname $(readlinke "$1"))'

alias cSDL="code '/mnt/c/Users/wgraham/Documents/Obsidian_vaults/Space Dynamics Lab'"
alias cWORK="code '/mnt/c/Users/wgraham/Documents/Obsidian_vaults/Work'"

# default editors and compilers
export VISUAL=vim
export EDITOR="$VISUAL"
export MAKEFLAGS="-j 16"
export CC=gcc
export CCX=g++
export CXXFLAGS="${CXXFLAGS} -fdiagnostics-color=always"
export CPPFLAGS="${CPPFLAGS} -fdiagnostics-color=always"
export CMAKE_GENERATOR="Ninja"

# fd-find stuff
export FZF_DEFAULT_COMMAND='fdfind --type file --no-hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

# Exa config stuff
alias ls="exa"
alias ll="exa -alh"
alias tree="exa --tree"

##### SDL VPN stuff ##### 
export QT_X11_NO_MITSHM=1
export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-0
export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
export PULSE_SERVER=/mnt/wslg/PulseServer
#export DOCKER_HOST=tcp://localhost:2375 # This thing keeps breaking everything...
export GPG_TTY=$(tty)
export DOTFILE_DIR="/home/will/personal/Dotfiles"
wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit start

### PATH Edits ###
# Add .local/bin and rust
export PATH=/home/will/.local/bin:/opt/nvim:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source "$HOME/.cargo/env"


### oh-my-posh evaluation ###
eval "$(oh-my-posh init zsh --config "~/.config/ohmyposh/powerlevel10k_rainbow.omp.json")"

### Zoxide ###
# Zoxide Initialization (do not move away from being the last line)
eval "$(zoxide init zsh)"
