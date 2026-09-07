# 2019 MacBook Pro Dotfiles

This folder contains the legacy dotfiles and configurations specific to the 2019 Intel MacBook Pro.

## Available Configurations
This directory contains organized configurations for various development tools and environments:
- **ZSH / Bash**: Shell profiles (`.zshrc`, `.bashrc`), aliases, and zprezto configurations.
- **Vim**: `.vimrc`, `.gvimrc`, and custom python snippets.
- **Tmux**: Terminal multiplexer configuration (`.tmux.conf`) and status bar styling.
- **VS Code**: User settings, keybindings, and custom code snippets (Python, Shell).
- **SSH**: Legacy SSH config setup.
- **Terminals**: Profiles and color schemes for iTerm2 and Hyper terminal.
- **Browsers**: Chrome bookmarks backup.
- **Doc**: Miscellaneous documentation, notes, and setup guides for GCP and Git.

## Setup Scripts

This folder provides several scripts to help automate the environment setup:

- **`softlink_config_file.sh`**: The primary script. It iterates through the specific config files in this repository and creates softlinks (symlinks) to their expected locations in the home directory (`~/`).
- **`softlink_folder.bash`**: A helper script utilized to symlink entire directories at once, rather than individual files.
- **`setup_old_mac.sh`**: A legacy initialization script originally created for an older MacBook (circa 2015). It is kept here for historical reference and is not intended to be run on the 2019 machine.

## Configuration Setup

The configuration files in this directory are softlinked to their respective locations in the user's home directory (`~/`). This mechanism ensures that any local modifications made on this specific machine are automatically synced back to this folder, allowing for seamless synchronization via Dropbox and Git.

### Establishing Links

To set up the environment and establish the necessary softlinks on this machine, execute the primary linking script:

```bash
bash softlink_config_file.sh
```

*(Note: For information regarding the multi-machine repository structure, please refer to the `README.md` at the root of the repository.)*