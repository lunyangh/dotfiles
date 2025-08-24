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

# name of ssh key file 
FILENAME="gc-vm-personal"
# commnt about which user this key belongs to 
USER_NAME="lunyang"

# run script would ask for passphrase, you can just use empty.

echo "Starting script in directory: $(pwd)"

ssh-keygen -t rsa -f ~/.ssh/$FILENAME -C $USER_NAME

echo "Script finished successfully."
