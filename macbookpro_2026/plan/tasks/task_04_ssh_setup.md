# Task 04: SSH Configuration Setup

**Context:** Over time, SSH configs accumulate legacy host mappings, deprecated proxy commands, and old IPs. For the 2026 Mac, the user explicitly requested a "clean slate" for SSH to prevent carrying over outdated or insecure connections.

## Instructions for Agent

### 1. Source Files
An empty, fresh SSH configuration file has already been initialized at:
`computer_config/dotfiles/macbookpro_2026/ssh_config/config`

This file is intentionally left blank except for header comments.

### 2. Establish Softlink & Security
The deployment script must establish the softlink while strictly adhering to SSH's built-in security constraints. If permissions are too open, SSH will abort connections with a `Bad owner or permissions` error.

The agent executing `softlink_config_file.sh` will ensure:
1. The `~/.ssh` directory is created.
2. The directory permissions are locked down to `700` (Owner read/write/execute only).
3. The symlink is created from the repository to `~/.ssh/config`.

*(Note: The user will manually add new SSH keys and host mappings to this file as needed on the new machine.)*
