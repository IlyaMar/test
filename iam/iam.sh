curl https://auth.yandex.cloud/oauth/userinfo -H "Authorization: Bearer $(ycp --profile prod iam create-token)"

ycp --profile prod oauth claim get --subject-ids ajele9dp0oc631ihg4t0


ycp --profile prod --impersonate-service-account-id yc.iam.service-account maintenance access-service dynamic-values get-all-values


ycp --profile ${PROFILE?} iam backoffice  access-binding list-by-subject --subject-id ajekdpbsrmuo96650cb0
ycp --profile prod iam backoffice  access-binding list-by-subject --subject-id ajegl9pkjspvn0go9vn9

ycp --profile=$PROFILE iam backoffice permission check -r - <<REQ
resource_path:
- id: b1gl6hmon4mjhp15svvv
  type: resource-manager.cloud
permission: compute.osLogin.users.get
subject:
  service_account:
    id: yc.compute.tf-compute-metadata-sa
REQ


ycp --profile internal-dev iam backoffice  access-binding list-by-subject --subject-id yc.iam.metadata-deployer


export YCP_PROFILE=
export YCP_PROFILE=internal-prestable
export YC_IAM_TOKEN=
export YC_IAM_TOKEN=$(ycp --profile ${YCP_PROFILE?} iam iam-token create-for-service-account --service-account-id yc.iam.service-account)
export YC_IAM_TOKEN=$(ycp --profile ${YCP_PROFILE?} iam iam-token create-for-service-account --service-account-id yc.iam.metadata-deployer)
ycp --profile $YCP_PROFILE maintenance access-service dynamic-values cache-refresher unset  --instance-id iam-internal-prestable-klg1

export YCP_PROFILE=prod
export YC_IAM_TOKEN=
export YC_IAM_TOKEN=$(ycp --profile ${YCP_PROFILE?} iam iam-token create-for-service-account --service-account-id yc.iam.service-account)
export YC_IAM_TOKEN=$(ycp --profile ${YCP_PROFILE?} iam iam-token create-for-service-account --service-account-id yc.iam.metadata-deployer)
ycp iam o-auth-client list


ycp --profile testing --impersonate-service-account-id yc.iam.service-account iam key create -r -<<REQ
description: "metro PoC"
format: json
key_algorithm: RSA_4096
service_account_id: yc.iam.rm-control-plane
REQ

yc --profile testing iam key create --algorithm rsa-4096 --service-account-id yc.iam.resource-manager-control-plane --output yc.iam.resource-manager-control-plane-key.json




