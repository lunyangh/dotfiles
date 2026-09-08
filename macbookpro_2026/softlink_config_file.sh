#!/bin/bash
set -e

# Identify the absolute path of this script's directory
dotfile_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
echo "Establishing softlinks from: $dotfile_path"
echo "====================================="

link_zsh() {
    echo "Linking ZSH..."
    ln -sf "$dotfile_path/ZSH config/.zshrc" ~/.zshrc
    echo "✅ ZSH linked."
}

link_vim() {
    echo "Linking Vim..."
    ln -sf "$dotfile_path/vim_config/.vimrc" ~/.vimrc
    ln -sf "$dotfile_path/vim_config/.gvimrc" ~/.gvimrc
    echo "✅ Vim linked."
}

link_vscode() {
    echo "Linking VS Code..."
    vscode_dir="$HOME/Library/Application Support/Code/User"
    mkdir -p "$vscode_dir/snippets"
    ln -sf "$dotfile_path/vs_code_config/setting/settings.json" "$vscode_dir/settings.json"
    ln -sf "$dotfile_path/vs_code_config/keybinding/keybindings.json" "$vscode_dir/keybindings.json"
    ln -sf "$dotfile_path/vs_code_config/snippet/shell_snippet.json" "$vscode_dir/snippets/shellscript.json"
    ln -sf "$dotfile_path/vs_code_config/snippet/python_snippet.json" "$vscode_dir/snippets/python.json"
    echo "✅ VS Code linked."
}

link_tmux() {
    echo "Linking Tmux..."
    mkdir -p ~/.tmux/plugins
    ln -sf "$dotfile_path/tmux config/.tmux.conf" ~/.tmux.conf
    ln -sf "$dotfile_path/tmux config/.tmux_status_bar" ~/.tmux/.tmux_status_bar
    ln -sf "$dotfile_path/../../terminal/tmux/tmux-resurrect" ~/.tmux/plugins/tmux-resurrect
    echo "✅ Tmux linked."
}

link_ssh() {
    echo "Linking SSH Config..."
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    chmod 600 "$dotfile_path/ssh_config/config"
    ln -sf "$dotfile_path/ssh_config/config" ~/.ssh/config
    echo "✅ SSH linked."
}

target="${1:-all}"

case "$target" in
    zsh)
        link_zsh
        ;;
    vim)
        link_vim
        ;;
    vscode)
        link_vscode
        ;;
    tmux)
        link_tmux
        ;;
    ssh)
        link_ssh
        ;;
    all)
        link_zsh
        link_vim
        link_vscode
        link_tmux
        link_ssh
        echo "====================================="
        echo "✅ All 2026 MacBook Pro softlinks established successfully!"
        ;;
    *)
        echo "Unknown component: $target. Valid options: zsh, vim, vscode, tmux, ssh, all"
        exit 1
        ;;
esac
