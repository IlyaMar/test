#!/bin/bash -eEu
set -o pipefail

zones="b d"
for zone in $zones; do
  echo $zone
  pushd app-$zone
  terraform init
  terraform state rm module.app.module.app.helm_release.chart
  terraform import module.app.module.helm.helm_release.chart iam-idp-auth-service/app-ru-central1-$zone-0
  popd

  pushd app-$zone-canary
  terraform init
  terraform state rm module.app.module.app.helm_release.chart
  terraform import module.app.module.helm.helm_release.chart iam-idp-auth-service/app-ru-central1-$zone-1
  popd
done
