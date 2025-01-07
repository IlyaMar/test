#!/bin/bash -eEu
set -o pipefail


folders="
yc.compute.tf-compute-metadata-sa
yc.compute.tf-compute-node-sa
yc.compute.node.image-downloader
yc.compute.node.memory-dump-uploader
yc.iam.oslogin-daemon
yc.dns.infra-monitoring-sa
yc.infra.compute-node-sa
yc.infra.kubelet-sa
yc.unified-agent-sa
yc.nbs.nbs-hw-sa
yc.compute.tf-compute-metadata-sa
yc.compute.tf-compute-node-sa
yc.compute.node.image-downloader
yc.compute.node.memory-dump-uploader
yc.iam.oslogin-daemon
yc.vpc.network-flow-collector.sa
yc.vpc.node.sa
"

profile=kz

function process() {
  sa=$1
#  echo "processing SA $sa"
  folder_id=$(ycp --profile $profile --impersonate-service-account-id yc.iam.service-account iam service-account get ${sa?} | yq .folder_id)
  cloud_id=$(ycp --profile $profile --impersonate-service-account-id yc.iam.service-account resource-manager folder get ${folder_id?} | yq .cloud_id)
  echo "$cloud_id"
}


for f in $folders; do
  process $f
done

