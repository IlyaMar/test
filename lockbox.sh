

ycp --profile prod --impersonate-service-account-id yc.iam.service-account lockbox v1 secret create -r - <<REQ
folder_id: yc.iam.service-folder
name: robot-yc-iam
description: robot-yc-iam AWS access key
REQ

ycp --profile prod --impersonate-service-account-id yc.iam.service-account lockbox v1 secret add-version -r - <<REQ
secret_id: e6qj02pqsnk34ua5bna7
payload_entries:
  - key: aws_access_key_id
    text_value: J2Pflp34m...
  - key: aws_secret_access_key
    text_value: QL4i0OqOM0T...
REQ

ycp --profile prod --impersonate-service-account-id yc.iam.service-account lockbox v1 secret update-access-bindings -r - <<REQ
resource_id: e6qj02pqsnk34ua5bna7
access_binding_deltas:
- action: ADD
  access_binding:
    role_id: lockbox.payloadViewer
    subject:
      id: ajekdpbsrmuo96650cb0
      type: userAccount
REQ

