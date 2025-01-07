ycp --profile prod resource-manager cloud resolve --cloud-ids yc.imaginarium_cloud

ycp --impersonate-service-account-id yc.iam.service-account --profile $PROFILE resource-manager cloud list-operations -r - <<REQ | less
cloud_id: b1gfcpod5hbd1ivs7dav
REQ


CLOUD_ID=b1g48frd7ctf013qstft
ORG_ID=bpfi7sjv61porcmicq40
PROFILE=prod
ycp --profile="${PROFILE?}" resource-manager cloud move --impersonate-service-account-id yc.iam.service-account -r - <<< "{
  cloud_id: ${CLOUD_ID?},
  organization_id: ${ORG_ID?},
  mode: FORCE
}"




YC_IAM_TOKEN=$(ycp --profile=preprod iam iam-token create-for-subject --subject-id  yc.iam.service-account)
# impersonate to yc.iam.reaper inside script
~/arcadia/cloud/iam/scripts$ ./list-folder-resources.sh preprod aoe30e9fg8ar56367oid