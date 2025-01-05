yc-bootstrap --template testing.yaml --ticket-id CLOUD-119068 --filter host=iam-ts-vla1.svc.cloud-testing.yandex.net --apply - update-cluster --salt-role iam-base --salt-state roles.iam-base
yc-bootstrap --template prod.yaml --ticket-id CLOUD-119068 --filter host=iam-internal-dev-myt1.svc.cloud.yandex.net - update-cluster --salt-role iam-ya-base
yc-bootstrap --template prod.yaml --ticket-id CLOUD-144044 --filter '%iam-control-plane @ru-central1-c' - update-cluster --salt-role iam-control-plane --salt-state roles.iam-control-plane
yc-bootstrap --template testing.yaml --ticket-id CLOUD-173108 --filter host=iam-as-vla1.svc.cloud-testing.yandex.net --apply - update-cluster --salt-role common --salt-state roles.common

--salt-role common --salt-state common.unified-agent
--salt-state roles.iam-ya-base
--template prod.yaml --filter role=iam-internal-dev
--template testing.yaml --filter role=iam-access-service
--filter role=compute --filter zone=ru-central1-c
                                                                                                              salt-state                                    path-to-file
salt-call --local --config-dir /srv/yc/ci/salt-formulae/common/data/etc/salt state.sls_id /etc/yandex/unified_agent/secrets/access-service_secret.txt common.unified-agent.configure  test=True
salt-call --local --config-dir /srv/yc/ci/salt-formulae/common/data/etc/salt state.sls roles.common test=True queue=True


yc-bootstrap --template testing.yaml --ticket-id CLOUD-173108 --filter host=iam-as-vla1.svc.cloud-testing.yandex.net --apply \
- update-cluster --salt-role common --salt-state roles.common


# Local render, from salt-formula/tests
make test-render-salt.iam-token-service.testing FROM_FILE=False
make test-render-salt.iam-ya.prod FROM_FILE=False
make test-render-salt.iam-internal-prestable.prod FROM_FILE=False
make test-render-salt.iam-internal-dev.prod FROM_FILE=False
make test-render-salt.iam-base.hw4-lab FROM_FILE=False LOG_LEVEL=DEBUG

# Override grains. Base role's salt-roles list stored in grains. Create tests/render_salt/test_grains/grains_testing, modify host vla04-ct5-1.cloud.yandex.net roles list.
# For lab. Add stand to tests/Makefile:
supported_stands := testing preprod prod israel nemax cloudvm hw-cgw-dev-lab



yc-bootstrap --apply --ticket-id COMPUTEOPS-1198  --template pre-prod.yaml --filter iam-as-myt3.svc.cloud-preprod.yandex.net - gather-hosts-cluster-map
