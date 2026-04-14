

ycp --profile prod --impersonate-service-account-id yc.iam.service-account lockbox v1 secret create -r - <<REQ
folder_id: yc.iam.service-folder
name: robot-yc-iam
description: robot-yc-iam AWS access key
REQ

ycp --profile prod --impersonate-service-account-id yc.iam.service-account lockbox v1 secret add-version -r - <<REQ
secret_id: e6qnpojkp72bnkoro120
payload_entries:
  - key: tvm_secret
    text_value: J2Pflp34m...
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

