# Personal Dotfiles

This repository contains my personal dotfiles and development environment configurations.

## Repository Structure

To safely maintain configurations across different computers without synchronization conflicts, this repository uses a machine-specific folder architecture:

* **`macbookpro_2019/`**: Legacy configurations and setup scripts specifically tailored for the 2019 Intel MacBook Pro.
* *(Future machines will have their own dedicated directories here, e.g., `macbookpro_2026/`)*

## Setup & Synchronization

Because these configurations are synchronized directly via Dropbox, maintaining separate directories ensures that changes made on a new machine do not accidentally overwrite the symlink targets or configurations of older machines.

### Installation

To set up a machine:
1. Navigate into the specific directory for your current machine.
2. Execute the corresponding softlink script (e.g., `softlink_config_file.sh`) to bind the configurations to your home directory.
