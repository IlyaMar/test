
PROFILE=testing
SA_ID=eve
ycp --profile=${PROFILE} iam backoffice access-binding list-by-subject --subject-id ${SA_ID} > sa_bindings_$PROFILE.txt

# REMOVE
# root. /duty access
yq "[ .[] | select(.resource.type == \"root\")
| {\"role_id\": .role_id, \"subject\": {\"id\": \"$SA_ID\", \"type\": \"serviceAccount\"}} | {\"action\": \"REMOVE\", \"access_binding\": .} ]
| {\"access_binding_deltas\": .}" sa_bindings_$PROFILE.txt \
| ycp --profile ${PROFILE?} iam root update-access-bindings -r -

# cloud
yq -o=json ".[] | select(.resource.type == \"resource-manager.cloud\")
| {\"resource_id\": .resource.id, \"private_call\": true, \"access_binding_deltas\": [
   {
   \"action\": \"REMOVE\", \"access_binding\": {\"role_id\": .role_id, \"subject\": {\"id\": \"$SA_ID\", \"type\": \"serviceAccount\"}}
   }
]}"  sa_bindings_$PROFILE.txt | jq -c '.' | while read -r binding_update_data; do
    echo $binding_update_data
    ycp --profile $PROFILE --impersonate-service-account-id yc.iam.service-account resource-manager cloud update-access-bindings --format json -r - <<REQ
    $binding_update_data
REQ
done

# get clouds
yq -o=json ".[] | select(.resource.type == \"resource-manager.cloud\")
| {\"cloud_id\": .resource.id}"  sa_bindings_$PROFILE.txt | jq -c '.' | while read -r data; do
  ycp --profile $PROFILE --impersonate-service-account-id yc.iam.service-account resource-manager cloud get -r - <<REQ
  $data
REQ
done



# ADD
the same, change command to ADD