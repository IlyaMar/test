TICKET=YCIAM-7833
BASE_ROLES="%iam-access-service %iam-activeprobes %iam-control-plane %iam-openid-server %iam-org-service %iam-oslogin-service %iam-quota-manager %iam-reaper %iam-resource-manager-control-plane %iam-sync %iam-token-service"
BASE_ROLES_INTERNAL="%iam-ya %iam-internal-dev %iam-internal-prestable"
export YC_IAM_TOKEN=$YANDEX_YC_IAM_TOKEN
yc-bootstrap --batch-size 1  --template testing.yaml --ticket-id  $TICKET --filter '%iam-access-service tag=canary @ru-central1-a' --apply - update-cluster --salt-role common --salt-state roles.common 
yc-bootstrap --batch-size 10 --template testing.yaml --ticket-id  $TICKET --filter "${BASE_ROLES} tag=canary" --apply - update-cluster --salt-role common --salt-state roles.common  --max-fail 5
yc-bootstrap --batch-size 20 --template testing.yaml --ticket-id  $TICKET --filter "${BASE_ROLES} tag_neg=canary" --apply - update-cluster --salt-role common --salt-state roles.common --max-fail 5


# preprod canary zone a:
yc-bootstrap --batch-size 2 --template pre-prod.yaml --ticket-id  $TICKET --filter '%iam-access-service tag=canary @ru-central1-a' --apply - update-cluster --salt-role common --salt-state roles.common
yc-bootstrap --batch-size 10 --template pre-prod.yaml --ticket-id  $TICKET --filter "${BASE_ROLES} tag=canary" --apply - update-cluster --salt-role common --salt-state roles.common --max-fail 10
yc-bootstrap --batch-size 20 --template pre-prod.yaml --ticket-id  $TICKET --filter "${BASE_ROLES} tag_neg=canary" --apply - update-cluster --salt-role common --salt-state roles.common --max-fail 10


# prod canary zone a:
yc-bootstrap --batch-size 3 --template prod.yaml --ticket-id  $TICKET --filter '%iam-access-service tag=canary @ru-central1-a' --apply - update-cluster --salt-role common --salt-state roles.common --max-fail 10
# prod all canary zone a:
yc-bootstrap --batch-size 10 --template prod.yaml --ticket-id  $TICKET --filter "${BASE_ROLES} ${BASE_ROLES_INTERNAL} tag=canary @ru-central1-a" --apply - update-cluster --salt-role common --salt-state roles.common --max-fail 10
# prod all not canary zone a:
yc-bootstrap --batch-size 20 --template prod.yaml --ticket-id  $TICKET --filter "${BASE_ROLES} ${BASE_ROLES_INTERNAL} tag_neg=canary @ru-central1-a" --apply - update-cluster --salt-role common --salt-state roles.common  --max-fail 10
# prod all zone b:
yc-bootstrap --batch-size 20 --template prod.yaml --ticket-id  $TICKET --filter "${BASE_ROLES} ${BASE_ROLES_INTERNAL} @ru-central1-b" --apply - update-cluster --salt-role common --salt-state roles.common --max-fail 10
# prod all zone d:
yc-bootstrap --batch-size 20 --template prod.yaml --ticket-id  $TICKET --filter "${BASE_ROLES} ${BASE_ROLES_INTERNAL} @ru-central1-d" --apply - update-cluster --salt-role common --salt-state roles.common --max-fail 10


#kz access-service canary:
yc-bootstrap --batch-size 1 --template kz.yaml --ticket-id  $TICKET --filter '%iam-access-service tag=canary' --apply - update-cluster --salt-role common --salt-state roles.common --max-fail 1
#kz all canary:
yc-bootstrap --batch-size 5 --template kz.yaml --ticket-id  $TICKET --filter "${BASE_ROLES} tag=canary" --apply - update-cluster --salt-role common --salt-state roles.common --max-fail 2
#kz all not canary:
yc-bootstrap --batch-size 10 --template kz.yaml --ticket-id  $TICKET --filter "${BASE_ROLES} tag_neg=canary" --apply - update-cluster --salt-role common --salt-state roles.common --max-fail 2
