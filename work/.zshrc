### ZSH Config ###
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
d2p(){
  base="${1%.d2}"  # Remove .d2 if present
  d2 --watch "$base.d2" "$base.svg"
}
d2pz(){
  base="${1%.d2}"  # Remove .d2 if present
  scale="${2}"
  d2 --scale "$scale" --watch --browser=0 "$base.d2" "$base.svg"
}
function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )
    
    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}
alias z.="cd .."
alias z..="cd ../../"
alias z...="cd ../../.."
alias z....="cd ../../../.."
# TODO: fix the following line to jump into directory of a symlink
# alias symdir='$(dirname $(readlinke "$1"))'

declare -rx EVAL_CACHE_DIR="$HOME/.cache/eval"
if [[ ! -d "$EVAL_CACHE_DIR" ]]; then
    mkdir -p "$EVAL_CACHE_DIR"
fi

 # WSL  (from Michael)
 if uname -r | grep -q "WSL"; then 
    declare -xr ON_WSL=true 
    export PATH="$PATH:/mnt/c/Windows/System32"  # Bunch of system-level binaries for windows
    export PATH="$PATH:/mnt/c/Windows/System32/WindowsPowerShell/v1.0" 
    # export PATH="$PATH:/mnt/c/Program Files/Git/cmd" 


    # Sets up windows username constant
    if [[ ! -f "$EVAL_CACHE_DIR/wsl_constants.bash" ]]; then 
        echo "Performing WSL first time setup. . ." 
        # shellcheck disable=SC2016 
        echo "declare -xr WINDOWS_USERNAME=\"$(powershell.exe -Command 'echo $env:USERNAME' | tr -d '\r')\"" > "$EVAL_CACHE_DIR/wsl_constants.bash" 
    fi

    source "$EVAL_CACHE_DIR/wsl_constants.bash"

    # Add specific programs I want to path...

    # export PATH="$PATH:/mnt/c/users/$WINDOWS_USERNAME/AppData/Local/Mozilla Firefo
    export PATH="$PATH:/mnt/c/users/$WINDOWS_USERNAME/AppData/Local/Programs/Microsoft VS Code/bin"
    export PATH="$PATH:/mnt/c/Windows/SysWOW64/" # Added for explorer.exe
    export PATH="$PATH:/mnt/c/Program Files/Google/Chrome/Application/"
    # export BROWSER=firefox.exe 
    # alias firefox firefox.exe 
    # alias chrome chrome.exe
 fi 
# default editors and compilers
export VISUAL=nvim
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

# xdg-open config

# Exa config stuff
alias ls="exa"
alias ll="exa -alh"
alias tree="exa --tree"

# Navi CLI tool config
export NAVI_PATH="~/.config/navi:~/.local/share/navi/cheats"

# yazi config
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
export YAZI_CONFIG_HOME="~/.config/yazi/"

# ripgrep config
export RIPGREP_CONFIG_PATH="$HOME/.rgrc"

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
# Add snap to path
export PATH=$PATH:/snap/bin
export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
# Add .local/bin and rust
export PATH=/home/will/.local/bin:/opt/nvim:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source "$HOME/.cargo/env"
# Dedupe path arg
PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"


### oh-my-posh evaluation ###
eval "$(oh-my-posh init zsh --config "~/.config/ohmyposh/powerlevel10k_rainbow.omp.json")"

# Can remove later...
alias pdf2code='source ~/pdf2code/.venv/bin/activate && python ~/pdf2code/pdf2code_v2.py'


### Zoxide ###
# Zoxide Initialization (do not move away from being the last line)
eval "$(zoxide init zsh)"
