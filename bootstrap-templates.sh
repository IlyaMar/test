
export YANDEX_YC_IAM_TOKEN=$(ycp --profile ${YCP_PROFILE?} iam iam-token create-for-service-account --service-account-id yc.iam.service-account)
pssh --cause other:YCIAM-5501 bootstrap-b.gear.cloud.yandex.net --send-env YANDEX_YC_IAM_TOKEN
export YC_IAM_TOKEN=$YANDEX_YC_IAM_TOKEN
yc-bootstrap --template pre-prod.yaml --ticket-id YCIAM-2374 - provision-default-resources --resources-path iam -target ycp_resource_manager_folder_iam_member.yc-iam-logs-folder-logging-writer-role-hwnodes


yc-bootstrap --templates-repo-branch=iam_mk8s --template prod.yaml --ticket-id CLOUD-215223  - provision-default-resources --resources-path iam/terraform
yc-bootstrap --template prod.yaml --ticket-id YCIAM-4589 - provision-default-resources --resources-path iam/as-overlay
# --apply -


yc-bootstrap --template pre-prod.yaml --ticket-id CLOUD-143756 --filter host=myt1-ct7-4.cloud.yandex.net
--apply - update-cluster --salt-role iam-token-agent --salt-state roles.iam-token-agent

yc-bootstrap --template pre-prod.yaml --ticket-id CLOUD-143756 --filter host=myt1-ct7-4.cloud.yandex.net
 --apply  - init-iam-agent-hosts


--filter role=compute --filter zone=ru-central1-a

HOST_FQDN=iam-as-overlay-vla2.svc.cloud.yandex.net
yc-bootstrap --template="prod.yaml" --filter="${HOST_FQDN?}" --ticket-id YCIAM-4589 --apply add-svms