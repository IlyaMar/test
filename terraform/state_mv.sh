#!/bin/bash -eEu
set -o pipefail

zones="b d"

function process_env() {
  env=$1
  echo $env
  pushd $env

  terraform init

  pull_services=$(terraform list | grep ycp_monitoring_service_pull)

  for pull_service in $pull_services; do
    terraform state mv $pull_service "$pull_service[0]"
    terraform import module.app.module.helm.helm_release.chart iam-idp-auth-service/app-ru-central1-$zone-0
    popd

    pushd app-$zone-canary
    terraform init
    terraform state rm module.app.module.app.helm_release.chart
    terraform import module.app.module.helm.helm_release.chart iam-idp-auth-service/app-ru-central1-$zone-1
    popd
  done
}


envs="
testing
preprod
prod
"

#for env in $envs; do
#  process_env $env
#done
