### Clone a Repository and Set Up Remote with GitHub CLI

This guide outlines the process of cloning a repository and setting up the remote using the GitHub CLI (`gh`) on a fresh server.

-----

### Step 1: Install GitHub CLI

First, you need to install `gh` on your server. The installation process varies depending on your operating system.

**For Debian/Ubuntu:**
See [link](https://github.com/imjasonh/gh-cli/blob/trunk/docs/install_linux.md) for updated instructions

install 
```bash
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

update 
```bash 
sudo apt update
sudo apt install gh
```


For other operating systems, you can find detailed instructions on the official GitHub CLI website.

-----

### Step 2: Authenticate with GitHub

Instead of using a Personal Access Token (PAT) in the clone URL, you'll use the `gh auth login` command to authenticate your session.

1.  Run the login command:
    ```bash
    gh auth login
    ```
2.  The CLI will ask you a series of questions.
      * **Where do you want to use GitHub?** Choose `github.com`.
      * **What is your preferred protocol for Git operations?** Choose `HTTPS`.
      * **How would you like to authenticate?** Choose **Log in with a web browser**.
3.  The CLI will provide you with a one-time code and open a URL in your browser. Copy the code and go to the URL.
4.  Paste the code and authorize the GitHub CLI application. Once you've done this, your terminal session will be authenticated.

-----

### Step 3: Clone the Repository

Once authenticated, you can clone the repository using the standard `git clone` command. The authentication token is managed securely by the GitHub CLI, so you don't need to embed it in the URL.

```bash
git clone https://github.com/USERNAME/REPOSITORY.git
```

This command will clone the repository, and subsequent `git push` and `git pull` operations will automatically use the authentication token stored by `gh`.

-----

### Step 4: Clean Up (When Finished)

Before deleting the server, it's a good practice to explicitly log out to revoke the authentication token.

```bash
gh auth logout
```