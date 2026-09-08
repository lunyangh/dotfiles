# --- 1. HOMEBREW ENVIRONMENT (Must be first for Apple Silicon) ---
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- 2. PRE-OH-MY-ZSH CONFIGURATIONS (Themes & Styling) ---
ZSH_THEME=""
zstyle ':omz:update' mode disabled

# --- SPACESHIP PROMPT CONFIGURATION ---
SPACESHIP_PROMPT_ORDER=(
    battery
    user
    dir
    venv
    char
)
SPACESHIP_RPROMPT_ORDER=( git )

# General
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=false

# Char & Time
SPACESHIP_CHAR_SYMBOL=">>"
SPACESHIP_CHAR_PREFIX=""
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_TIME_SHOW=false

# User & Dir
SPACESHIP_USER_SHOW=true
SPACESHIP_DIR_PREFIX=""
SPACESHIP_DIR_SUFFIX=" "
SPACESHIP_DIR_TRUNC=1
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_COLOR='yellow'

# Git
SPACESHIP_GIT_PREFIX='git:'
SPACESHIP_GIT_SUFFIX=" "

# VENV (Crucial for uv compatibility)
SPACESHIP_VENV_SHOW=true
SPACESHIP_VENV_PREFIX="venv:"
SPACESHIP_VENV_SUFFIX=" "

# Hide unused legacy environments
SPACESHIP_CONDA_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_PYTHON_SHOW=false
SPACESHIP_VI_MODE_SHOW=false

# --- AUTOSUGGESTIONS STYLING ---
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=gray,underline"

# --- 3. OH MY ZSH INITIALIZATION ---
export ZSH="$HOME/.oh-my-zsh"
plugins=(git macos ssh)
[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# --- 4. ENVIRONMENT, PATH & ALIASES ---
# Load Spaceship via Homebrew
[[ -f /opt/homebrew/opt/spaceship/spaceship.zsh ]] && source /opt/homebrew/opt/spaceship/spaceship.zsh

# Path updates for uv and local binaries
export PATH="$HOME/.local/bin:$PATH"

# Default Editor
export EDITOR=vim
export VISUAL=vim

# Setup ls colors
export LSCOLORS=exfxfeaeBxxehehbadacea

# Disable auto cd (from 2019 config)
unsetopt AUTO_CD

# Enable emacs keybinding
bindkey -e

# Jupyter notebook alias
alias jb='jupyter lab --notebook-dir=.'

# Tmux related aliases
alias tn='tmux new-session -s'
alias ta='tmux attach -t'
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'
alias tcls='tmux clear-history'

# --- 5. CLI INTEGRATIONS ---
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v fzf >/dev/null && eval "$(fzf --zsh)"

# --- 6. PLUGINS & SYNTAX HIGHLIGHTING (Must be at the absolute bottom) ---
[[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor pattern)
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  ZSH_HIGHLIGHT_STYLES[builtin]="fg=cyan,bold"
  ZSH_HIGHLIGHT_STYLES[command]="fg=yellow,bold"
  ZSH_HIGHLIGHT_STYLES[function]="fg=cyan,bold"
  ZSH_HIGHLIGHT_STYLES[alias]="fg=red"
  ZSH_HIGHLIGHT_STYLES[path]="fg=magenta"
  ZSH_HIGHLIGHT_STYLES[globbing]="fg=magenta"
  ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=yellow"
  ZSH_HIGHLIGHT_STYLES[comment]="fg=green,bold"
  ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=white"
  ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
fi
