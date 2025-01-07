#!/bin/bash -ex

services="
access-service
iam-control-plane
iam-activeprobes
"

version=`date +"%Y%m%d-%H%M%S"`
collect_folder=dc_logs_${version?}
collect_dir=/tmp/$collect_folder
archive=${version}.zip

rm -rf ${collect_dir?}
mkdir $collect_dir

function copy_log() {
    service=$1
    file=$2
    pod=$3
    kubectl exec -c $service $pod -- tail -10000 /var/log/yc/$service/$file > $collect_dir/$service/$file || return 0
    #kubectl cp -c $service $pod:/var/log/yc/$service/${file}_short $collect_dir/$service/$file
    #kubectl exec -c $service $pod -- rm -f /var/log/yc/$service/${file}_short
}


for service in $services; do
  echo "collecting for service $service"
  mkdir $collect_dir/$service
  pods=$(kubectl get pod -l yc.iam.app=$service --output=jsonpath={.items..metadata.name})

  for pod in $pods; do
    echo "pod $pod"
    copy_log $service access.log $pod
    copy_log $service server.log $pod
  done
done

archive=${collect_folder}.zip
pushd $collect_dir
zip $archive -r .
popd
