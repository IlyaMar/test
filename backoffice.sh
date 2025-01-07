ycp --profile ${PROFILE?} iam backoffice  access-binding list-by-subject --subject-id ajekdpbsrmuo96650cb0

ycp --profile=$PROFILE iam backoffice permission check -r - <<REQ
resource_path:
- id: b1gl6hmon4mjhp15svvv
  type: resource-manager.cloud
permission: compute.osLogin.users.get
subject:
  service_account:
    id: yc.compute.tf-compute-metadata-sa
REQ

