#!/bin/sh
set -x

switch_cl7() {
  local ROLE="$1"
  local HOST="$2"
  pssh run --cause other:CLOUD-236092 "sudo sed -i.bak 's/base_role: ${ROLE}$/base_role: ${ROLE}-cl7/' /etc/yc/enginfra-locallb-agent/config.yaml && sudo systemctl restart yc-enginfra-locallb-agent" $HOST
}

switch_back() {
  local ROLE="$1"
  local HOST="$2"
  pssh run --cause other:fix "sudo mv /etc/yc/enginfra-locallb-agent/config.yaml.bak /etc/yc/enginfra-locallb-agent/config.yaml && sudo systemctl restart yc-enginfra-locallb-agent" $HOST
}

switch_back  iam-resource-manager iam-rm-vla1.svc.cloud.yandex.net
# switch_cl7  iam-resource-manager iam-rm-vla1.svc.cloud.yandex.net
# switch_cl7  iam-org-service      iam-org-klg1.svc.cloud-preprod.yandex.net
# switch_cl7  iam-control-plane    iam-cp-klg1.svc.cloud-preprod.yandex.net
# switch_cl7  iam-reaper           iam-reaper-klg1.svc.cloud-preprod.yandex.net
# switch_cl7  iam-openid-server    iam-openid-klg1.svc.cloud-preprod.yandex.net
# switch_cl7  iam-token-service    iam-ts-klg1.svc.cloud-preprod.yandex.net
# switch_cl7  iam-activeprobes     iam-activeprobes-klg1.svc.cloud-preprod.yandex.net

#switch_back  iam-resource-manager iam-rm-kz1-a1.svc.yacloudkz.tech

# later
#switch_cl7  iam-oslogin-service  iam-oslogin-klg1.svc.cloud-testing.yandex.net
#switch_cl7  iam-quota-manager    iam-qm-klg1.svc.cloud-testing.yandex.net
#switch_cl7  iam-quota-manager    iam-qm-klg1.svc.cloud-testing.yandex.net