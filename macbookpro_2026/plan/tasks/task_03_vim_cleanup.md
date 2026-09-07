# Task 03: Vim Configuration Cleanup & Migration

**Context:** The old Mac had a heavily customized Vim/MacVim configuration. For the new Mac, the user wants a fast, minimal setup. The `.vimrc` file has already been prepared and purged of outdated plugins, retaining only the essential UI configuration (`vim-plug` with `airline` and `onedark`) to preserve the user's preferred aesthetic. The one-time download and installation logic is separated from the config file itself.

## Instructions for Agent

### 1. Source Files
The finalized, plugin-light configuration file is already located at:
`computer_config/dotfiles/macbookpro_2026/vim_config/.vimrc`

### 2. Establish Softlink
The deployment script handles this, symlinking `.vimrc` to `~/.vimrc`.

### 3. Install Package Manager and Plugins
Run the following one-time shell commands to download the lightweight `vim-plug` manager and automatically trigger the installation of the UI plugins:

```bash
# 1. Download vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 2. Run Vim headlessly to install plugins
vim +PlugInstall +qall
```
