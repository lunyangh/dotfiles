# Overview 

Documents how to configure google cloud from scratch in personal google account. 

# Aug 9, 2025

## Project

Project level: 

* Create a new personal project   
* Delete the “My First Project” in default 

## GCS

Google cloud storage: 

* Create the first storage bucket in google cloud. 

## Google doc

* In dropdown menu, Set file \-\> page setup to set to “pageless”   
* In dropdown menu, set tools \-\> preferences to set “enable markdown”

Add ons: 

* Personal google doc does not support code block. Function, you may add through extension. Though less convenient. 

## Setup first VM server 

### Setup first custom boot disk: 
* Create the first custom boot disk 
    * go to "disk" tab in google compute engine to create disk before creating VM
    * give name 
    * currently size of 40g
        * this can be increased later but not decreased.
    * set backup schedule as weekly.
        * create a custom renamed schedule. 
    * setup to use a public image: 
        * let's use the one called debian-12, bookworm
            * search "bookworm" in filter, you will see two options, choose one without arm64
                * name with arm64 is for arm64 architecture cpu 
                * name withou arm64 is typical x86/64 architecture for intel, amd cpu
    * balanced persistent disk 

### setup first VM based on custom book disk 

#### from custom disk
* click created custom disk, select "create vm", this will try to create vm based on this custom disk 

#### cpu and memory: 
* those are less important, we can start with E2.

#### network setup: 
* for ease of config, let's not use OS login (more consistent with future other small providers)
* setup an persistent external IP address, 
    * this helps the same SSH config would work. See [this doc](./gcp_detail/setup_external_ip.md)

####  API access: 
* setup API access. 
    * full access to 
        * compute engine 
        * google cloud storage 
        * bigquery

#### ssh key access: 

Some reference docs of SSH:
[concept of ssh](./ssh/ssh_basic.md): what ssh is about
[ssh in google cloud](./gcp_detail/gcp_ssh.md): for basics of ssh with google cloud
[vscode in os login](./gcp_detail/vscode_os_login.md): details for vscode remote connection when using ssh.

Since this is personal project folder. I prefer to 
    * setup project level ssh key pairs, allow all machines to use project level ssh key to authenticate

To setup ssh config to login vm via manual project level ssh. follow this [doc](./gcp_detail/project_ssh_manual_setup.md)

some customization steps: 
    * change ssh key file name from google-cloud-ssh
    * configure username used in login VM.
    * update config in `~.ssh/config` for new VM configuration.

  



