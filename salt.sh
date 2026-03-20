export YANDEX_YC_IAM_TOKEN=$(ycp --profile ${YCP_PROFILE?} iam iam-token create-for-service-account --service-account-id yc.iam.service-account)
export YC_IAM_TOKEN=$YANDEX_YC_IAM_TOKEN
yc-bootstrap --template testing.yaml --ticket-id CLOUD-119068 --filter host=iam-ts-vla1.svc.cloud-testing.yandex.net --apply - update-cluster --salt-role iam-base --salt-state roles.iam-base
yc-bootstrap --template prod.yaml --ticket-id CLOUD-119068 --filter host=iam-internal-dev-myt1.svc.cloud.yandex.net - update-cluster --salt-role iam-ya-base
yc-bootstrap --template prod.yaml --ticket-id CLOUD-144044 --filter '%iam-control-plane @ru-central1-c' - update-cluster --salt-role iam-control-plane --salt-state roles.iam-control-plane
yc-bootstrap --template testing.yaml --ticket-id CLOUD-173108 --filter host=iam-as-vla1.svc.cloud-testing.yandex.net --apply - update-cluster --salt-role common --salt-state roles.common
yc-bootstrap --template testing.yaml --ticket-id CLOUD-173108 --filter host=hwnode1.yandex.net - update-cluster --salt-role infra-automation --salt-state roles.infra-automation

yc-bootstrap --batch-size 3 --template testing.yaml --ticket-id NOTICKET --filter '%iam-access-service %iam-activeprobes %iam-control-plane %iam-openid-server %iam-org-service %iam-oslogin-service %iam-quota-manager %iam-reaper %iam-resource-manager-control-plane %iam-sync %iam-token-service tag=canary' --apply - update-cluster --salt-role common --salt-state roles.common




--salt-role common --salt-state common.unified-agent
--salt-state roles.iam-ya-base
--template prod.yaml --filter role=iam-internal-dev
--template testing.yaml --filter role=iam-access-service
--filter role=compute --filter zone=ru-central1-c
                                                                                                              salt-state                                                 path-to-file
salt-call --local --config-dir /srv/yc/ci/salt-formulae/common/data/etc/salt            state.sls_id /etc/yandex/unified_agent/secrets/access-service_secret.txt common.unified-agent.configure  test=True queue=True 
salt-call --local --config-dir /srv/yc/ci/salt-formulae/infra-automation2/data/etc/salt state.sls_id /etc/yandex/unified_agent/conf.d/logs/yc-iam-oslogin-daemon-logs.yml roles.infra-automation test=True queue=True

salt-call --local --config-dir /srv/yc/ci/salt-formulae/common/data/etc/salt state.sls roles.common test=True queue=True
salt-call --local --config-dir /srv/yc/ci/salt-formulae/iam-access-service/data/etc/salt state.sls roles.iam-access-service  queue=True


yc-bootstrap --template testing.yaml --ticket-id CLOUD-173108 --filter host=iam-as-vla1.svc.cloud-testing.yandex.net --apply \
- update-cluster --salt-role common --salt-state roles.common


# Local render, from salt-formula/tests. Prod grains parsing consume more 2Gb RAM, docker container terminated
make test-render-salt.iam-token-service.testing FROM_FILE=False
make test-render-salt.iam-ya.prod FROM_FILE=False
make test-render-salt.iam-internal-prestable.prod FROM_FILE=False
make test-render-salt.iam-internal-dev.prod FROM_FILE=False
make test-render-salt.iam-base.hw4-lab FROM_FILE=False LOG_LEVEL=DEBUG
make STANDS=testing LOG_LEVEL=debug FROM_FILE=true ROLES=compute CUSTOM_ARGS="--salt-roles compute-cp-vpc"
make STANDS=preprod FROM_FILE=true ROLES=cloudvm CUSTOM_ARGS="--salt-roles iam-control-plane"



# Override grains. Base role's salt-roles list stored in grains. Create tests/render_salt/test_grains/grains_testing, modify host vla04-ct5-1.cloud.yandex.net roles list.
# For lab. Add stand to tests/Makefile:
supported_stands := testing preprod prod israel nemax cloudvm hw-cgw-dev-lab



yc-bootstrap --apply --ticket-id COMPUTEOPS-1198  --template pre-prod.yaml --filter iam-as-myt3.svc.cloud-preprod.yandex.net - gather-hosts-cluster-map


sudo -i YC_BS_ID=yc-b-t6o7bp5dvievr9ciu /opt/yc-ci-remote/yc-ci-remote run-salt --state roles.iam-access-service --salt-role iam-access-service --salt-formula-package-version 0.1-148027.250808 --timeout 1800 --json-out-file yc-b-t6o7bp5dvievr9ciu.roles.iam-access-service.1d7pcv0mu0ke021ah.json --salt-cpu-limiters none

# cloudvm
sudo -i /opt/yc-ci-remote/yc-ci-remote run-salt --state roles.iam-token-agent --salt-role iam-token-agent --salt-formula-package-version 0.1-0.260311.custom.bd3a389d --timeout 1800 --json-out-file unknown.roles.iam-token-agent.fgjmdou2autuv4sp5.json --salt-cpu-limiters none
