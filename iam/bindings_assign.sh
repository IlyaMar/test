PROFILE=kz
IAM_TOKEN=...
YC_IAM_TOKEN=${IAM_TOKEN?} ycp --profile $PROFILE resource-manager cloud update-access-bindings -r  - <<REQ
resource_id: yc.iam.service-cloud
private_call: true
access_binding_deltas:
- action: ADD
  access_binding:
    role_id: admin
    subject:
      id: yc.iam.service-account
      type: serviceAccount
REQ


ycp --profile=doublecloud-aws-prod organization-manager organization update-access-bindings -r - <<REQ
resource_id: com13q11uk1ukhc07r1s
private_call: true
access_binding_deltas:
- action: REMOVE
  access_binding:
    role_id: internal.organization-manager.member
    subject:
      id: accprficvkejaqpod15q
      type: federatedUser

ycp --profile ${PROFILE?} iam root update-access-bindings -r - <<REQ
access_binding_deltas:
- action: REMOVE
  access_binding:
    role_id: ${ROLE_ID?}
    subject:
      id: ${SA_ID?}
      type: serviceAccount
REQ





grpcurl -H "Authorization: Bearer ${SA_IAM_TOKEN?}" -d ''{"access_binding_deltas":[{"action":"ADD","access_binding":{"role_id":"admin","subject":{"id":"yc.iam.serivce-account","type":"serviceAccount"}}}],"private_call":true,"resource_path":[{"id":"yc.iam.service-cloud","type":"resource-manager.cloud"}]}'' ops.private-api.iam.internal.double.tech:4283 yandex.cloud.priv.iam.v1.AccessBindingService/UpdateAccessBindings
