# this need to be changed. but just an example.
# generated from google cloud console
gcloud compute instances create dev-vm-v1-0 \
    --project=sr-slow-research-main \
    --zone=us-central1-c \
    --machine-type=e2-custom-8-65536 \
    --network-interface=address=34.63.162.156,network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --metadata=enable-osconfig=TRUE,enable-oslogin=true \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --service-account=research-vm@sr-slow-research-main.iam.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --create-disk=boot=yes,device-name=custom-boot-v1-20250629,image=projects/debian-cloud/global/images/debian-12-bookworm-v20250610,mode=rw,size=10,type=pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ops-agent-policy=v2-x86-template-1-4-0,goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any \
&& \
printf 'agentsRule:\n  packageState: installed\n  version: latest\ninstanceFilter:\n  inclusionLabels:\n  - labels:\n      goog-ops-agent-policy: v2-x86-template-1-4-0\n' > config.yaml \
&& \
gcloud compute instances ops-agents policies create goog-ops-agent-v2-x86-template-1-4-0-us-central1-c \
    --project=sr-slow-research-main \
    --zone=us-central1-c \
    --file=config.yaml \
&& \
gcloud compute resource-policies create snapshot-schedule schedule-1 \
    --project=sr-slow-research-main \
    --region=us-central1 \
    --max-retention-days=14 \
    --on-source-disk-delete=keep-auto-snapshots \
    --daily-schedule \
    --start-time=00:00 \
    --storage-location=us \
&& \
gcloud compute disks add-resource-policies custom-boot-v1-20250629 \
    --project=sr-slow-research-main \
    --zone=us-central1-c \
    --resource-policies=projects/sr-slow-research-main/regions/us-central1/resourcePolicies/schedule-1