# this is a script to track common terminal softwares to install for basic setup.

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
echo "Script finished successfully."

# update linux software indexing
sudo apt update 

# install git, for clone repo 
sudo apt install -y git-all


# config git globally property
# git config --global user.name slowres1937
# git config --global user.email slowres1937@gmail.com 

# setup github CLI to manage git access. 
# see https://docs.github.com/en/get-started/git-basics/caching-your-github-credentials-in-git?platform=linux
sudo apt install -y gh
# configure login here
# gh auth login


# git clone gcp_env repo from slowres1937, note that you need a personal access token with read/write permission on repo:content 


# install zsh 
sudo apt install -y zsh

# switch default terminal to zsh 
# the chsh won't work due to os login has no password with user. 
# try gemini, the answer is adding something at the end of .bashrc and laucn zsh through .bashrc.
# use `echo $0` to check current shell verison.



# install fzf
# need to install from github, apt version in debian 12 is 0.38, too old.
# see install from git in https://github.com/junegunn/fzf#installation

# install zoxide (this is per user installation)
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# need to setup shell link 
# see https://github.com/ajeetdsouza/zoxide
# if zoxide command not found, it's because zoxide's install path is not added to $PATH, 
# run `find $HOME -type f -name zoxide 2>/dev/null` to find path of zoxide 
# assume path is `~/.local/bin/zoxide`
# then add to path `export PATH="$HOME/.local/bin:$PATH"`

# install oh my zsh 
# see official page.

# install zsh autosuggestion. 
# see https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md to install based on oh my zsh 

# install spaceship prompt
# don't need to install power font in terminal, as long as local computer has it.

# install zsh syntax highlight in oh my zsh

# install ranger 
sudo apt install ranger