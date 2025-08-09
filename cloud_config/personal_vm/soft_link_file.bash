# softlink dotfiles in remote VM.

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

# path variable 
dotfile_path="$HOME/projects/gcp_env"
# vs_code_config_path="$HOME/Library/Application Support/Code/User"

# bashrc configuration 
ln -sf "$dotfile_path/terminal_config/shell/.bashrc" ~/.bashrc

# zsh configuration
ln -sf "$dotfile_path/terminal_config/shell/.zshrc" ~/.zshrc

# spaceship prompt configuration 
ln -sf "$dotfile_path/terminal_config/shell/.spaceshiprc.zsh" ~/.spaceshiprc.zsh


# tmux code
# ln -sf "$dotfile_path/tmux config/.tmux.conf"  ~/.tmux.conf

# ln -sf "$dotfile_path/tmux config/.tmux_status_bar"  ~/.tmux/.tmux_status_bar


# # snippet files 
# ln -sf "$dotfile_path/vs_code_config/snippet/shell_snippet.json" "$vs_code_config_path/snippets/shellscript.json"

# ln -sf "$dotfile_path/vs_code_config/snippet/python_snippet.json" "$vs_code_config_path/snippets/python.json"


echo "Script finished successfully."


