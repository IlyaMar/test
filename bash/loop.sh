#!/bin/bash -eEu
set -o pipefail


for dir in app-*; do
  echo "terraform-chdir=./$dir  apply -auto-approve"
done




profile=kz
folders="
yc.iam.active-probes-folder
yc.iam.quota-manager-folder
yc.iam.sync
"

function process_instance() {
  instance=$1
  echo "processing instance $instance"
  ycp --profile $profile --impersonate-service-account-id yc.iam.service-account compute instance update ${instance?} -r- <<EOF
maintenance_policy: RESTART
update_mask:
  paths:
    - maintenance_policy
EOF

  ycp --profile $profile --impersonate-service-account-id yc.iam.service-account compute instance update ${instance?} -r- <<EOF
scheduling_policy: {deny_deallocation: False}
update_mask:
  paths:
  - scheduling_policy.deny_deallocation
EOF
}


for f in $folders; do
  instances=$(ycp --profile $profile compute instance list --folder-id=$f --raw | yq '.instances[] | .id')
  for instance in $instances; do
    process_instance $instance
  done
done

