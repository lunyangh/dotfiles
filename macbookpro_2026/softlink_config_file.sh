#!/bin/bash
set -e

# Identify the absolute path of this script's directory
dotfile_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
echo "Establishing softlinks from: $dotfile_path"

echo "====================================="

# 1. ZSH Configuration
echo "Linking ZSH..."
ln -sf "$dotfile_path/ZSH config/.zshrc" ~/.zshrc

# 2. Vim Configuration
echo "Linking Vim..."
ln -sf "$dotfile_path/vim_config/.vimrc" ~/.vimrc
ln -sf "$dotfile_path/vim_config/.gvimrc" ~/.gvimrc

# 3. VS Code Configuration
echo "Linking VS Code..."
# AGENT ACTION: Verify this VS Code path on the new Mac! (e.g. Code vs Code - Insiders)
vscode_dir="$HOME/Library/Application Support/Code/User" # CHANGE THIS IF NEEDED
mkdir -p "$vscode_dir/snippets"
ln -sf "$dotfile_path/vs_code_config/setting/settings.json" "$vscode_dir/settings.json"
ln -sf "$dotfile_path/vs_code_config/keybinding/keybindings.json" "$vscode_dir/keybindings.json"
ln -sf "$dotfile_path/vs_code_config/snippet/shell_snippet.json" "$vscode_dir/snippets/shellscript.json"
ln -sf "$dotfile_path/vs_code_config/snippet/python_snippet.json" "$vscode_dir/snippets/python.json"

# 4. Tmux Configuration
echo "Linking Tmux..."
mkdir -p ~/.tmux/plugins
ln -sf "$dotfile_path/tmux config/.tmux.conf" ~/.tmux.conf
ln -sf "$dotfile_path/tmux config/.tmux_status_bar" ~/.tmux/.tmux_status_bar

# Link the plugin from the central computer_config folder back to the standard tmux location
# $dotfile_path is .../computer_config/dotfiles/macbookpro_2026, so ../../ is computer_config/
ln -sf "$dotfile_path/../../terminal/tmux/tmux-resurrect" ~/.tmux/plugins/tmux-resurrect

# 5. SSH Configuration
echo "Linking SSH Config..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ln -sf "$dotfile_path/ssh_config/config" ~/.ssh/config

echo "====================================="
echo "✅ All 2026 MacBook Pro softlinks established successfully!"
