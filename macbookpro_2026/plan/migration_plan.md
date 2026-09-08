# 2026 MacBook Pro Configuration & Migration Plan

This document outlines the strategy for migrating configurations from the legacy `macbookpro_2019` setup to the new `macbookpro_2026` environment. Instead of blindly copying everything, we will selectively transfer, modernize, and clean up the dotfiles.

## 1. Terminal Environment & Software Installation

To set up the new Mac from scratch, install these terminal utilities sequentially:

1. **Homebrew**: The standard macOS package manager. (Installs Apple Silicon version to `/opt/homebrew`).
2. **iTerm2** (or preferred terminal): Will import the backed-up `com.googlecode.iterm2.plist` from the 2019 folder.
3. **Git**: Install via Homebrew.
4. **uv**: An extremely fast Python package and environment manager (replacing Conda). Installation: `curl -LsSf https://astral.sh/uv/install.sh | sh`
5. **Spaceship Prompt**: A minimal, customizable Zsh prompt. Since we are dropping Prezto, Spaceship will be installed natively via Homebrew (`brew install spaceship`) or cloned directly into a custom Zsh plugins folder.
6. **zoxide**: A smarter `cd` command (found in old `.zshrc`).
7. **fzf**: Command-line fuzzy finder.

## 2. Component Migration Strategies

### VS Code
- **Strategy:** Direct Transfer.
- **Action:** We will copy the `vs_code_config` folder (including `settings.json`, `keybindings.json`, and `snippets`) directly from `macbookpro_2019` into the `macbookpro_2026` folder and softlink them exactly as before.

### Tmux Configuration (`.tmux.conf` & `.tmux_status_bar`)
- **Strategy:** Direct Transfer with Central Plugin Management.
- **Action:** Softlink `~/.tmux.conf` and `~/.tmux/.tmux_status_bar` to maintain the custom `Option + p` prefix, Vi pane navigation, and Atom One Dark status bar. Link `tmux-resurrect` from the central `computer_config/terminal/tmux/` directory.

### Zsh Configuration (`.zshrc`)
- **Strategy:** Modernize and Clean up.
- **Actions:**
  - **Drop Conda:** Remove all Conda initialization blocks.
  - **Add uv:** Add `uv` autocompletion and environment paths.
  - **Drop Prezto:** Remove the `.zpreztorc` dependency and all Prezto-related initialization code from `.zshrc`.
  - **Spaceship Prompt:** Configure Spaceship natively in `.zshrc` without Prezto overhead.
  - **Cleanup:** Audit old aliases and paths (e.g., old GCP/Condor scripts) and retain only purely functional Zsh configs (like `zoxide` initialization).

### Vim Configuration (`.vimrc`)
- **Strategy:** Selective Transfer.
- **Actions:**
  - The old setup was heavily customized. On the new Mac, the goal is to rely primarily on the built-in macOS `vim` without overly complex plugin managers.
  - We will extract only the essential, universally compatible settings (like basic tab widths, line numbers, search highlighting, syntax on, and custom Python snippets) into a fresh `.vimrc`.
  - Discard outdated heavyweight plugins unless specifically required.
