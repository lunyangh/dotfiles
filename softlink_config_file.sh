#!/bin/bash

# Exit upon first error
set -e
# change directory to bash script
pushd "$(dirname "")" >/dev/null
# print error upon exit,  return to original dir regardless error or not
handle_error() {
  echo "Error: Command failed at line BASH_LINENO" >&2
  popd >/dev/null 
  exit 1
}
trap 'handle_error' ERR
trap 'popd >/dev/null 2>&1' EXIT

# --- script content goes below this line ---

echo "Starting script in directory: $(pwd)"
echo "Script finished successfully."

# path variable 
dotfile_path="$HOME/dropbox/project/terminal/dotfiles"
vs_code_config_path="$HOME/Library/Application Support/Code/User"
ssh_config_path="$HOME/.ssh"

# vim configuration
ln -sf "$dotfile_path/vim config/.vimrc" ~/.vimrc
ln -sf "$dotfile_path/vim config/.gvimrc" ~/.gvimrc
# zsh configuration
ln -sf "$dotfile_path/ZSH config/.zshrc" ~/.zshrc
# zprezto configuration
ln -sf "$dotfile_path/ZSH config/.zpreztorc" ~/.zpreztorc

# tmux code
ln -sf "$dotfile_path/tmux config/.tmux.conf"  ~/.tmux.conf

ln -sf "$dotfile_path/tmux config/.tmux_status_bar"  ~/.tmux/.tmux_status_bar

# python snippets
ln -sf "$dotfile_path/Vim config/snippets/python.snippets" ~/.vim/user_snippets/python.snippets

# jupytext configuration 
ln -sf "$dotfile_path/ZSH config/.jupytext" ~/.config/.jupytext
# vs code configuration
ln -sf "$dotfile_path/vs_code_config/settings.json" "$vs_code_config_path/settings.json"
ln -sf "$dotfile_path/vs_code_config/keybindings.json" "$vs_code_config_path/keybindings.json"

# snippet files 
ln -sf "$dotfile_path/vs_code_config/snippet/shell_snippet.json" "$vs_code_config_path/snippets/shellscript.json"

ln -sf "$dotfile_path/vs_code_config/snippet/python_snippet.json" "$vs_code_config_path/snippets/python.json"



# ssh configuration 
ln -sf "$dotfile_path/ssh_config/ssh_config" "$ssh_config_path/config"





