# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
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

zstyle ':completion::omz:plugins:docker' legacy-completion yes
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
zinit snippet OMZP::history
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found
zinit snippet OMZP::git



# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# set up oh my posh with theme
eval "$(oh-my-posh init zsh --config '~/.config/ohmyposh/powerlevel10k_rainbow.json')"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
#bindkey '^I'   complete-word       # tab | complete

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
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

### Aliases ###
alias ls='ls --color'
alias vim='nvim'
#alias c='clear'
alias fd='fdfind'
alias bc='batcat'
# Docker
alias dc='docker compose'
alias de='docker exec -it'

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
# Failed attempt to jump into directory of a symlink
# alias symdir='$(dirname $(readlinke "$1"))'

#export GIT_EDITOR=vim

# default editors
export VISUAL=vim
export EDITOR="$VISUAL"
export MAKEFLAGS="-j 16"
export CMAKE_COLOR_DIAGNOSTICS=ON # You don't need this part; it's just helps me identify warnings an such
export CMAKE_GENERATOR=Ninja
export NINJA_STATUS="[%f/%t %p :: %e] "

# fd-find stuff
export FZF_DEFAULT_COMMAND='fdfind --type file --no-hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

# Exa config stuff
alias ls="exa"
alias ll="exa -alh"
alias tree="exa --tree"

# SDL VPN stuff
alias sdl_vpn=`wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit start`
#export DOCKER_HOST=localhost:2375

# Docker vars
#export QT_X11_NO_MITSHM=1
#export DISPLAY=:0
#export WAYLAND_DISPLAY="wayland-0"
#export XDG_RUNTIME_DIR="/mnt/wslg/runtime-dir"
#export PULSE_SERVER="/mnt/wslg/PulseServer"
#export DOCKER_HOST=localhost:2375

source "$HOME/.cargo/env"
# Zoxide Initialization (do not move away from being the last line)
eval "$(zoxide init zsh)"
