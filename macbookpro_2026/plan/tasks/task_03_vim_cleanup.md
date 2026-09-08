# Task 03: Vim Configuration Cleanup & Migration

**Context:** The old Mac had a heavily customized Vim/MacVim configuration. For the new Mac, the user wants a fast, minimal setup. The `.vimrc` file has already been prepared and purged of outdated plugins, retaining only the essential UI configuration (`vim-plug` with `airline` and `onedark`) to preserve the user's preferred aesthetic. The one-time download and installation logic is separated from the config file itself.

## Instructions for Agent

### 1. Source Files
The finalized, plugin-light configuration file is already located at:
- `computer_config/dotfiles/macbookpro_2026/vim_config/.vimrc`
- `computer_config/dotfiles/macbookpro_2026/vim_config/.gvimrc`

### 2. Establish Softlink via Script
The deployment script handles this modularly via `./softlink_config_file.sh vim`:
- `~/.vimrc` -> `macbookpro_2026/vim_config/.vimrc`
- `~/.gvimrc` -> `macbookpro_2026/vim_config/.gvimrc`

### 3. Install Package Manager and Plugins
```bash
# 1. Download vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 2. Run Vim headlessly to install plugins
vim +PlugInstall +qall
```

### 4. CLI Integration
- Softlink MacVim's command-line binary `/Applications/MacVim.app/Contents/bin/mvim` into `~/.local/bin/mvim`.

---

## Status & Notes (Completed)
- **Execution Date:** 2026-09-07
- **Status:** ✅ Completed and Verified
- **Verification Details:**
  - `~/.vimrc` and `~/.gvimrc` successfully softlinked via `softlink_config_file.sh vim`.
  - `vim-plug` installed at `~/.vim/autoload/plug.vim`.
  - Plugins installed to `~/.vim/plugged`: `onedark.vim`, `vim-airline`, and `vim-airline-themes`.
  - Verified clean, error-free Vim launch with Atom One Dark syntax highlighting and Airline status bar.
  - `mvim` CLI command softlinked to `~/.local/bin/mvim`.
  - **Font & Glyph Caveat:** Airline status bar uses Powerline symbols (``, ``, ``, ``). In terminal Vim, these render cleanly with `FiraCode Nerd Font` and iTerm2's built-in Powerline glyphs. In MacVim GUI, `.gvimrc` is configured with `guifont=FiraCode\ Nerd\ Font:h16,FiraCode\ Nerd\ Font\ Mono:h16` and enables `macligatures` so the status bar symbols render crisply.
