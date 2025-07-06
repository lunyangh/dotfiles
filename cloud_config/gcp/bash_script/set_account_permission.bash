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

# swtich bach to target user
gcloud config set account $TARGET_USER_EMAIL

echo "All specified IAM roles granted successfully."
echo "User '$TARGET_USER_EMAIL' can now SSH into OS Login-enabled VMs in project '$PROJECT_ID'."
echo "Their OS Login username will be derived from their email (e.g., ${TARGET_USER_EMAIL//[@.]/_})."
echo "Ensure OS Login is enabled on your VMs (project-level metadata 'enable-oslogin: TRUE')."




