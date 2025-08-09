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


sudo apt update 

# install git, for clone repo 
sudo apt install -y git-all

# config git globally 
git config --global user.name slowres1937
git config --global user.email slowres1937@gmail.com

# git clone gcp_env repo from slowres1937, note that you need a personal access token with read/write permission on repo:content 



# install zoxide 
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# need to setup shell link 




