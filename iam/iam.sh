curl https://auth.yandex.cloud/oauth/userinfo -H "Authorization: Bearer $(ycp --profile prod iam create-token)"

ycp --profile prod oauth claim get --subject-ids ajele9dp0oc631ihg4t0


ycp --profile prod --impersonate-service-account-id yc.iam.serviceAccount maintenance access-service dynamic-values get-all-values


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

