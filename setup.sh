# path variable 
dotfile_path="$HOME/Dropbox (Personal)/Projects/Terminal/dotfiles"
vs_code_config_path="$HOME/Library/Application Support/Code/User"

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
ln -sf "$dotfile_path/vs_code_config/keyboards.json" "$vs_code_config_path/keyboards.json"





