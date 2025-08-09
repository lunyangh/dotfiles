# Overview 

Discusses

* What is SSH   
* How to login terminal in remote server from local computer.  
  * SSH key based   
  * OS login (current choice) 

# SSH premiere 

See ssh basic for some concepts of public key and private keys about ssh. [google\_cloud\_setup\_note](https://docs.google.com/document/d/1X-xBlfcD2rJUyHEtcEl6HQ9Y6IRmGfQ5JIqSl8w3InU/edit?tab=t.vl8p7wiw1b5n)

**Do this before setting user configuration**  
We need to resolve login questions before setting up per user configurations. As per user configuration depends on user name. 

Main reference: 

* Google cloud doc discuss this: [https://cloud.google.com/compute/docs/instances/access-overview](https://cloud.google.com/compute/docs/instances/access-overview)  
* Answers provided by gemini (in chat history)

Imagine you want to send a secret message to someone, and you want to be sure only they can read it, and they want to be sure it truly came from you. This is what public-key cryptography, which SSH uses, helps achieve.

# SSH key based login 

Note: this ssh approach will **not work** with OS-login now enabled. Roughly speaking, os-login checks google account when login, this approach generates a local ssh key to check. See login access tab [google\_cloud\_setup\_note](https://docs.google.com/document/d/1X-xBlfcD2rJUyHEtcEl6HQ9Y6IRmGfQ5JIqSl8w3InU/edit?tab=t.8e7vxzsn3yhq)

## Gcloud ssh 

After setting setup, we can use `gcloud compute ssh` to ssh from local computer terminal into VM’s terminal. 

`gcloud compute ssh —-help`  to give you more detail about the syntax. 

Typical use case is   
`gcloud compute ssh –project {project} –zone {zone} {vm_name}` 

Notes: 

* The first time ssh into some instance, google will check some private, public key to setup ssh connection. They might ask you for a passphrase.   
  * We didn’t set passphrase, so type enter to confirm (empty) is enough.   
* A more convenient way is to copy the ssh command from google cloud console webpage.   
  * In the page of VM instances. Click view gcloud command under `SSH` tab (the arrow dropdown menu), will give you the generated gcloud command for ssh. 

![][image1]

## Setup ssh config 

For vscode type ssh remote into virtual machine. We want to write ssh config for connecting   
`gcloud compute ssh-config` 

This command will:

* Discover all your VM instances across all zones and projects accessible by your `gcloud` account.  
* Generate SSH key pairs (if they don't already exist) that `gcloud` uses for authentication.  
* Add entries to your `~/.ssh/config` file, creating aliases for each VM.  
* Again You might be prompted for a passphrase for the SSH key it generates/uses.

Once the ssh config is generated in \~/.ssh/config. You may remote connect to the vm through vscode.

		

## Vscode ssh into vm 

After correctly config ssh in ssh config file. 

### Download following extension in vscode

* Remote-ssh  
* Remote-development   
* Remote explorer   
* Remote \-ssh: editing configuration files 

### Steps to Connect VS Code Remote \- SSH:

* Open VS Code on your local machine.  
* Open the Command Palette:  
  * Press Ctrl+Shift+P (Windows/Linux) or Cmd+Shift+P (macOS).  
* In command palette: Search for "Remote-SSH: Connect to Host...":  
  * For first time, if you don’t see any option,   
    * select `configure ssh host`  
    * Select \~/.ssh/config  (path of ssh config file) to parse  
    * After that, you should be able to see VM in the config. 

### Static IP 

If you read the ssh config entry in \~/.ssh/config. You will notice 

* Outer level `Host` is the alias we use to login   
* Inner level key `HostName` is an explicit IP address. This is the IP address we ssh into. It is the external IP address VM provide. 

External IP address of a VM will change for each start/stop. A new external IP address is obtained when start VM. Unless we reserve a static IP address. 

Two options: 

* If we keep the dynamic IP address nature, we will need to run `gcloud compute config-ssh` each time we restart VM.   
* We can either reserve a static IP address to use, then restart VM does not affect IP address. 

# OS login: 

## What is OS login

Roughly speakly, OS login links login of VM to specific google account we use. Rather than create user name on VM (default is based on user name in our local computer, if user is sam in local computer, you will login as sam in VM if OS login not enabled).

See this google reference: [https://cloud.google.com/compute/docs/oslogin](https://cloud.google.com/compute/docs/oslogin)

## Enable OS login 

OS login is enabled at google project level or VM instance level. This works by setting `metadata` either at instance or project level with `enable-oslogin`\=True. 

See this google reference: [https://cloud.google.com/compute/docs/oslogin/set-up-oslogin](https://cloud.google.com/compute/docs/oslogin/set-up-oslogin)

## SSH under OS login

TL;DR: 

Setup 

First login with `gcloud compute ssh`  to vm for the first time to setup SSH key.

Copy follow (modify User and IdentityFile location) to \~/.ssh/config (if file does not exist, create one, plain text)

`User` can be found via `gcloud compute os-login describe-profile` ‘s username section.  
`IdentityFile` can be found from the added config via running `gcloud compute config-ssh` (though added config is not usable once we enable OS-login)

| Host dev-vm-v1   User slowresearcher\_gmail\_com   IdentityFile /Users/{user}/.ssh/google\_compute\_engine   IdentitiesOnly=yes   CheckHostIP=no      ProxyCommand gcloud compute ssh %h \--project=sr-slow-research-main \--zone=us-central1-c \--tunnel-through-iap \--ssh-flag="-W %h:%p" |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |

More details:   
See tab vscode\_os\_login [google\_cloud\_setup\_note](https://docs.google.com/document/d/1X-xBlfcD2rJUyHEtcEl6HQ9Y6IRmGfQ5JIqSl8w3InU/edit?tab=t.qvwpbfltrvtm). 

Reference doc to login ssh: 

* Google cloud doc: [https://console.cloud.google.com/compute/instances?authuser=3\&hl=en\&inv=1\&invt=Ab2CiQ\&project=sr-slow-research-main](https://console.cloud.google.com/compute/instances?authuser=3&hl=en&inv=1&invt=Ab2CiQ&project=sr-slow-research-main)

## Adding other gmail account

After enable OS login (currently at project level in SR account), each login is linked with an google account. To add other google account (to distinguish user) to access SR account’s VM, we need to setup the IAM permission. Roughly speaking, grant the other google account relevant permissions. 

### Permission: 

Different permissions can be searched here: [https://cloud.google.com/iam/docs/roles-permissions](https://cloud.google.com/iam/docs/roles-permissions)

We are primarily interested permission to: 

* Access VM   
* Access storage bucket. 

Gemini suggests following permissions: 

* roles/compute.admin  
* roles/compute.osAdminLogin  
* roles/iam.serviceAccountUser  
* roles/iap.tunnelResourceAccessor  
* roles/storage.objectAdmin

After setting permission, should be able to login resources using another google account.

### Sample code 

A sample bash script to add relevant permissions in this case. 


```bash
#!/bin/bash

# This script automates granting necessary IAM roles for a Google Cloud user
# to access VMs via OS Login, including sudo access, at the project level.

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

# --- Configuration ---
ORIGINAL_USER_EMAIL=slowresearcher@gmail.com
TARGET_USER_EMAIL=slowres1937@gmail.com
PROJECT_ID=sr-slow-research-main

# switch to account can grant permission
gcloud config set account $ORIGINAL_USER_EMAIL
# --- Grant IAM Roles ---

echo "Granting IAM roles to $TARGET_USER_EMAIL in project $PROJECT_ID..."

# 1. Grant the chosen OS Login role
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
   --member="user:$TARGET_USER_EMAIL" \
   --role="roles/compute.osAdminLogin" \
   --quiet || exit 1

# 2. Grant the Service Account User role (common requirement)
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
   --member="user:$TARGET_USER_EMAIL" \
   --role="roles/iam.serviceAccountUser" \
   --quiet || exit 1

# 3. Grant the IAP-secured Tunnel User role (crucial for IAP tunneling)
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
   --member="user:$TARGET_USER_EMAIL" \
   --role="roles/iap.tunnelResourceAccessor" \
   --quiet || exit 1

# 4. Grant google cloud storage
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
   --member="user:$TARGET_USER_EMAIL" \
   --role="roles/storage.admin" \
   --quiet || exit 1

# 5. Grant admin to all compute resources (this is easier for our collab)
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
   --member="user:$TARGET_USER_EMAIL" \
   --role="roles/compute.admin" \
   --quiet || exit 1

# switch bach to target user in gcloud
gcloud config set account $TARGET_USER_EMAIL

echo "All specified IAM roles granted successfully."
echo "User '$TARGET_USER_EMAIL' can now SSH into OS Login-enabled VMs in project '$PROJECT_ID'."
echo "Their OS Login username will be derived from their email (e.g., ${TARGET_USER_EMAIL//[@.]/_})."
echo "Ensure OS Login is enabled on your VMs (project-level metadata 'enable-oslogin: TRUE')."
```

