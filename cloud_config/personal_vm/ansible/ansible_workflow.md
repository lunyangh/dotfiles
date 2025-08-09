# Ansible Playbook: Debian VM Setup

This document describes an Ansible playbook designed to automate the setup of a new Debian 12 virtual machine. It installs a standard set of developer tools, including Git, GitHub CLI, Zsh, Ranger, FZF, Zoxide, and Oh My Zsh.

The primary benefit of using this playbook over a simple shell script is **idempotency**—it can be run multiple times without causing errors or unintended side effects. It checks the state of the system and only applies changes that are needed.

-----

## How to Use This Playbook

### 1\. Prerequisites

  - **Ansible:** You must have Ansible installed on your local computer (the one you're running commands from).
  - **SSH Access:** You need SSH key-based access to the remote Debian VM you intend to configure.

### 2\. File Setup

Create a directory on your local machine and place the following two files inside it.

#### `inventory.ini`

This file tells Ansible which server to connect to. Replace the IP address and username with your VM's details.

```ini
# File: inventory.ini
[vms]
198.51.100.10 ansible_user=your_remote_username
```

#### `setup-vm.yml`

This is the main playbook file containing all the instructions.

```yaml
# File: setup-vm.yml
---
- name: Configure New Debian VM
  hosts: all
  become: yes

  tasks:
    - name: Update apt package cache
      ansible.builtin.apt:
        update_cache: yes
      changed_when: false

    - name: Install required system packages
      ansible.builtin.apt:
        name:
          - git-all
          - gh
          - zsh
          - ranger
          - build-essential
        state: present

    - name: Clone fzf from GitHub
      ansible.builtin.git:
        repo: 'https://github.com/junegunn/fzf.git'
        dest: "/home/{{ ansible_user }}/.fzf"
        depth: 1
      become: no

    - name: Run fzf install script
      ansible.builtin.shell:
        cmd: "./install --all"
        chdir: "/home/{{ ansible_user }}/.fzf"
      become: no
      args:
        creates: "/home/{{ ansible_user }}/.fzf/bin/fzf"

    - name: Install zoxide
      become: no
      ansible.builtin.shell: >
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
      args:
        creates: "/home/{{ ansible_user }}/.local/bin/zoxide"

    - name: Check if Oh My Zsh is already installed
      become: no
      ansible.builtin.stat:
        path: "/home/{{ ansible_user }}/.oh-my-zsh"
      register: oh_my_zsh_stats

    - name: Install Oh My Zsh
      become: no
      ansible.builtin.shell: >
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      when: not oh_my_zsh_stats.stat.exists
```

### 3\. Execution

Navigate to your project directory in the terminal and run the following command:

```bash
ansible-playbook -i inventory.ini setup-vm.yml
```

Ansible will then connect to your VM and execute each task.

-----

## Playbook Task Breakdown

Here is a step-by-step explanation of what the playbook does.

### 1\. Update apt Package Cache

  - **What it does:** Runs the equivalent of `sudo apt update` to refresh the list of available software packages.
  - **Key parameters:** `update_cache: yes` tells the `apt` module to perform this action. `changed_when: false` prevents this step from being reported as a "change" every time it's run.

### 2\. Install Required System Packages

  - **What it does:** Installs a list of essential packages using the `apt` package manager.
  - **Key parameters:** `state: present` ensures that all packages listed (`git-all`, `gh`, etc.) are installed on the system. If they are already installed, Ansible does nothing.

### 3\. Clone fzf from GitHub

  - **What it does:** Clones the `fzf` fuzzy-finder tool from its official GitHub repository into the user's home directory.
  - **Key parameters:** `become: no` is crucial here; it tells Ansible to run this task as the remote user, not as root (`sudo`).

### 4\. Run fzf Install Script

  - **What it does:** Executes the `fzf` installation script.
  - **Key parameters:** The `args: { creates: ... }` block makes this step **idempotent**. The script will only run if the `fzf` binary does not already exist at the specified path, preventing re-installation.

### 5\. Install zoxide

  - **What it does:** Downloads and executes the installation script for `zoxide`, a "smarter `cd` command".
  - **Key parameters:** Like the `fzf` step, it uses `creates` to check if `zoxide` is already installed before running the command.

### 6\. Check if Oh My Zsh is Already Installed

  - **What it does:** This is a preparatory step. It uses the `stat` module to check for the existence of the `.oh-my-zsh` directory.
  - **Key parameters:** The result of this check (whether the directory exists) is stored in a variable named `oh_my_zsh_stats` using the `register` keyword.

### 7\. Install Oh My Zsh

  - **What it does:** Downloads and runs the unattended installation script for Oh My Zsh.
  - **Key parameters:** The `when: not oh_my_zsh_stats.stat.exists` condition is the most important part. It tells Ansible to **only** run this task if the check in the previous step found that the `.oh-my-zsh` directory does *not* exist.