* summarizes how to use personal access token for setting remote repo.

-----

### GitHub Personal Access Token (PAT) CLI Management

This guide provides a summary of how to use Git's credential-caching mechanisms to manage a GitHub Personal Access Token (PAT) for command-line operations, as explained in the video "Using Personal Access Tokens with GIT and GitHub."

-----

#### 1\. Generate Your Personal Access Token (PAT)

First, you need to generate a PAT from your GitHub account.

1.  Log in to GitHub.
2.  Navigate to **Settings** \> **Developer settings** \> **Personal access tokens** \> **Tokens (classic)**.
3.  Click **Generate new token (classic)**.
4.  Give the token a descriptive name and set an expiration date.
5.  Select the necessary scopes (e.g., `repo` for repository access).
6.  Click **Generate token**.
7.  **Copy the token immediately\!** GitHub will only show it to you once.

-----

#### 2\. Use the Token as a Password

The PAT is used as a replacement for your password. When Git prompts for credentials, you'll enter:

  * **Username:** Your GitHub username.
  * **Password:** The PAT you just copied.

-----

#### 3\. Cache the Token with Git's Credential Helper

Note that following method is suitable for linux. For macos, you can easily configure osxkeychain to cache credential,which is easier. 

```bash 
git config --global credential.helper osxkeychain
```
Some reference [doc](https://gist.github.com/jonjack/bf295d4170edeb00e96fb158f9b1ba3c)

You can use following command to list current config to understand your cache current config 

```bash
git config --list --show-origin
```


To avoid entering your PAT every time you perform a Git operation, you can configure Git to use the `cache` credential helper. This helper stores your credentials in memory for a limited amount of time, which is more secure than storing them in a file.

1.  **Configure the `cache` helper:**
    The following command sets the credential helper to `cache`.

    ```bash
    git config --global credential.helper cache
    ```

2.  **Set the timeout (optional but recommended):**
    By default, the cache expires after 15 minutes. You can increase this timeout to a longer period (e.g., one hour, or 3600 seconds) for convenience.

    ```bash
    git config --global credential.helper 'cache --timeout=3600'
    ```

The next time you perform a `git pull` or `git push`, Git will ask for your username and PAT. It will then cache this information, so you won't be prompted again until the timeout expires.

-----

#### 4\. Clear Cached Credentials

If you need to change your PAT or if you want to remove the cached credentials, you can use the following command to "unset" the credential helper:

```bash
git config --global --unset credential.helper
```

After running this, the next Git command that requires authentication will prompt you for your credentials again. You can then enter a new PAT, and Git will cache it as before.