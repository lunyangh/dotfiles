# 2019 MacBook Pro Dotfiles

This folder contains the legacy dotfiles and configurations specific to the 2019 Intel MacBook Pro.

## Configuration Setup

The configuration files in this directory are softlinked to their respective locations in the user's home directory (`~/`). This mechanism ensures that any local modifications made on this specific machine are automatically synced back to this folder, allowing for seamless synchronization via Dropbox and Git.

### Establishing Links

To set up the environment and establish the necessary softlinks on this machine, execute the provided script:

```bash
bash softlink_config_file.sh
```

*(Note: For information regarding the multi-machine repository structure, please refer to the `README.md` at the root of the repository.)*