# Overview 

This discusses how to setup ssh configuration to connect using openssh once you have a VM setup running. 
In the entire process, you don't need access to local google-cloud cli, thus process is applicable to other platforms as well.

-----

### SSH Access to Google Cloud VMs 🔐

This guide outlines the process of setting up project-level SSH access for Google Cloud VMs, allowing you to use a single key for all instances within a project. It also includes an advanced configuration for managing host keys in a personal environment.

-----

### 1\. Generate SSH Key Pair 🔑

On your local machine, generate an SSH key pair. The private key remains on your computer, while the public key is uploaded to Google Cloud.

```bash
ssh-keygen -t rsa -f ~/.ssh/gc-vm-personal -C "lunyang"
```

  * **`-t rsa`**: Specifies the RSA algorithm for the key.
  * **`-f ~/.ssh/gc-vm-personal`**: Sets the file name for the private key. The public key will be named `gc-vm-personal.pub`.
  * **`-C "lunyang"`**: Adds a comment to the key, which Google Cloud uses as your login username.

-----

### 2\. Add Public Key to Project Metadata

Add your public key to your project's SSH metadata. This makes the key available for all VMs in that project.

1.  Navigate to **Compute Engine \> Metadata** in the Google Cloud Console.
2.  Click the **SSH Keys** tab.
3.  Click **"Add SSH keys"** and paste the **entire content** of your public key file (`~/.ssh/gc-vm-personal.pub`).
4.  The username should be automatically populated from your key's comment.
5.  Click **"Save"**.

-----

### 3\. Configure Local SSH for Easy Access 💻

To simplify connecting and managing host keys for your VMs, add an entry to your local `~/.ssh/config` file. This configuration isolates your project's host keys from your general `known_hosts` file.

Open `~/.ssh/config` with a text editor and add the following block:

```sshconfig
Host personal-vm-v1
    # external ip of VM
    HostName [external id address]
    User lunyang
    # ssh key file 
    IdentityFile ~/.ssh/gc-vm-personal 
    IdentitiesOnly yes
    # skip checking hostkey is not known every time, hostkey is different for a different VM (a new hostkey if you delete and create a new VM with same external ip address)
    StrictHostKeyChecking no
    # separate location of host files
    UserKnownHostsFile ~/.ssh/gc-vm-personal_known_hosts
```

  * **`Host`**: An alias for the connection (e.g., `personal-vm-v1`).
  * **`HostName`**: The external IP address of your VM instance.
  * **`User`**: The username from your key's comment.
  * **`IdentityFile`**: The path to your private key.
  * **`IdentitiesOnly yes`**: Prevents SSH from trying other keys.
  * **`StrictHostKeyChecking no`**: Bypasses the initial prompt to verify the host key, which is useful when frequently recreating VMs.
  * **`UserKnownHostsFile`**: Specifies a dedicated file for storing the host keys for your Google Cloud VMs, isolating them from your main `known_hosts` file.

Now you can connect to your VM by simply running:

```bash
ssh personal-vm-v1
```