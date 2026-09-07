# Task 01: Complete Terminal Environment Setup (Homebrew, Fonts, Zsh)

**Context:** This task handles the end-to-end setup of the terminal environment. Because the package manager, fonts, terminal UI (Spaceship), and shell configurations (Zsh) are heavily intertwined, they are executed together here.

## 1. Install Homebrew
Install the native version of Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
*(Ensure `eval "$(/opt/homebrew/bin/brew shellenv)"` is run in the current session afterwards.)*

## 2. System Fonts Installation
Spaceship prompt and modern CLI tools require specific glyphs. Install the modern "Nerd Font" equivalent via Homebrew immediately so the system is ready to render UI elements correctly.
```bash
brew install --cask font-fira-code-nerd-font
```
*Note: After installation, open the terminal emulator (e.g., iTerm2) and set the font to `FiraCode Nerd Font`.*

## 3. Install CLI Utilities & Enhancements
With Homebrew and fonts ready, install the core workflow tools:
```bash
# Standard Tools
brew install git curl wget jq tmux tree tldr rsync pstree

# Modern Enhancements, Prompts & Zsh Plugins
brew install spaceship fzf ripgrep zoxide zsh-autosuggestions zsh-syntax-highlighting

# Clone Tmux Resurrect (Session saving plugin) to user-controlled central folder
# AGENT ACTION: Verify the actual Dropbox path on this new Mac first!
DROPBOX_PATH="$HOME/Dropbox (Personal)" # CHANGE THIS IF NEEDED
mkdir -p "$DROPBOX_PATH/computer_config/terminal/tmux"
git clone https://github.com/tmux-plugins/tmux-resurrect "$DROPBOX_PATH/computer_config/terminal/tmux/tmux-resurrect"
```

## 4. Install `uv` (Replacing Conda)
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## 5. Oh My Zsh Installation
Install Oh My Zsh to replace the legacy Prezto framework:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

## 6. Zsh Configuration Refactoring (.zshrc)

The legacy `.zshrc` contains outdated elements and incorrect loading orders that can cause plugin conflicts. 

**Action for Agent:**
Create a new, modernized `.zshrc` inside the `macbookpro_2026/ZSH config/` folder. **You must strictly follow this structural loading order** to prevent plugin conflicts (especially with syntax-highlighting). Use the following explicit code blocks:

### Step 1: Pre-Oh-My-Zsh Configurations (Themes & Styling)
These variables MUST be set before Oh My Zsh is sourced.
```zsh
# Enable Spaceship prompt via Homebrew
ZSH_THEME=""

# --- OH MY ZSH OPTIMIZATIONS (From Lightning AI) ---
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
SPACESHIP_PYENV_SHOW=false
SPACESHIP_VI_MODE_SHOW=false

# --- AUTOSUGGESTIONS STYLING ---
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=gray,underline"
```

### Step 2: Source Oh My Zsh
Add the standard Oh My Zsh initialization here, ensuring the `plugins` array carries over the user's legacy requirements:
```zsh
plugins=(git macos ssh)
source $ZSH/oh-my-zsh.sh
```

### Step 3: Keybindings, Environment, and Aliases
```zsh
# Load Spaceship via Homebrew
source $(brew --prefix)/opt/spaceship/spaceship.zsh

# Path updates for uv and brew
export PATH="$HOME/.local/bin:$PATH"

# Default Editor
export EDITOR=vim
export VISUAL=vim

# setup ls colors
export LSCOLORS=exfxfeaeBxxehehbadacea

# Disable auto cd (from 2019 config)
unsetopt AUTO_CD

# enable emacs keybinding
bindkey -e

# jupyter notebook related
alias jb='jupyter lab --notebook-dir=.'

# tmux related alias
alias tn='tmux new-session -s'
alias ta='tmux attach -t' 
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'
alias tcls='tmux clear-history'
```

### Step 4: CLI Integrations
These must be evaluated AFTER the path exports and aliases.
```zsh
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
```

### Step 5: The Absolute Bottom (Syntax Highlighting)
To prevent syntax-highlighting from failing to highlight custom aliases, it and autosuggestions **must** be the very last things loaded in the file.
```zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- CUSTOM ATOM ONE DARK SYNTAX HIGHLIGHTING ---
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor pattern)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
```
