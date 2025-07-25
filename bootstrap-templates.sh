
export YC_IAM_TOKEN=
yc-bootstrap --templates-repo-branch=iam_mk8s --template prod.yaml --ticket-id CLOUD-215223  - provision-default-resources --resources-path iam/terraform
yc-bootstrap --template prod.yaml --ticket-id YCIAM-4589 - provision-default-resources --resources-path iam/as-overlay
# --apply -


yc-bootstrap --template pre-prod.yaml --ticket-id CLOUD-143756 --filter host=myt1-ct7-4.cloud.yandex.net
--apply - update-cluster --salt-role iam-token-agent --salt-state roles.iam-token-agent

yc-bootstrap --template pre-prod.yaml --ticket-id CLOUD-143756 --filter host=myt1-ct7-4.cloud.yandex.net
 --apply  - init-iam-agent-hosts


--filter role=compute --filter zone=ru-central1-a

HOST_FQDN=iam-as-overlay-vla1.svc.cloud.yandex.net
yc-bootstrap --template="prod.yaml" --filter="${HOST_FQDN?}" --ticket-id YCIAM-4589 --apply add-svms