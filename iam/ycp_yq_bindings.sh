PROFILE=internal-dev
export YC_IAM_TOKEN=$(ycp --profile "${PROFILE?}" iam iam-token create-for-subject --subject-id yc.iam.service-account)

export RESOURCE_ID=yc.iam.service-cloud
ycp --profile=$PROFILE resource-manager cloud list-access-bindings --private-call --resource-id ${RESOURCE_ID?} \
  | yq '.[] | select(.role_id == "admin" and .subject.id != "yc.iam.service-account") | [.] | {"action": "REMOVE", "access_binding": .[]} | [.]' \
  | yq '{"resource_id": env(RESOURCE_ID), "private_call": true, "access_binding_deltas": .}' \
| ycp --profile ${PROFILE?} resource-manager cloud update-access-bindings -r -


export RESOURCE_ID=yc.iam.service-folder
ycp --profile=$PROFILE resource-manager folder list-access-bindings --private-call --resource-id ${RESOURCE_ID?} \
  | yq '.[] | select(true) | [.] | {"action": "REMOVE", "access_binding": .[]} | [.]' \
  | yq '{"resource_id": env(RESOURCE_ID), "private_call": true, "access_binding_deltas": .}' \
| ycp --profile ${PROFILE?} resource-manager folder update-access-bindings -r -


ycp --profile=$PROFILE iam gizmo list-access-bindings  \
  | yq '.[] | select(.subject.type == "userAccount") | [.] | {"action": "REMOVE", "access_binding": .[]} | [.]' \
  | yq '{"access_binding_deltas": .}' \
| ycp --profile ${PROFILE?} iam gizmo update-access-bindings -r -


export RESOURCE_ID=yc.iam.service-folder
ycp --profile=$PROFILE resource-manager folder list-access-bindings --private-call --resource-id ${RESOURCE_ID?} \
  | yq '.[] | select(.subject.type == "serviceAccount" and .subject.id == "yc.iam*" and .role_id == "editor" )       | [.] | {"action": "REMOVE", "access_binding": .[]} | [.]' \
  | yq '{"resource_id": env(RESOURCE_ID), "private_call": true, "access_binding_deltas": .}' \
| ycp --profile ${PROFILE?} resource-manager folder update-access-bindings -r -



for sa_id in `ycp --profile=doublecloud-aws-preprod iam service-account list --folder-id ecv6tts0tdgkm0gqjgb1 | yq '.[] | .id'`
do
  echo "$sa_id"
  ycp --profile=doublecloud-aws-preprod iam service-account delete $sa_id
done



ycp --profile=preprod iam root cloud list-access-bindings --private-call | yq '.[] | select(.subject.id != "yc.billing.svm")'
