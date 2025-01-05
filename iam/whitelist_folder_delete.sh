#!/bin/bash -eEu
set -o pipefail


folders_preprod="
aoed13imagmcglgptvgr
aoer26a5rbk1qejfbk3b
aoenl0bicf1ldatkoacv
aoec2p9340agujvbv1vi
"

folders_prod="
b1go9gvp3auf27v6slne
b1g3a93gm9bpmbg4pchr
b1ga5h4iu7psrfni06u8
b1gre5mo34afhseet36j
b1gada732m240pggjrq5
"

folders_kz="
ao7rlh8nh5qf2flabtb5
"


function set_bindings() {
  PROFILE=$1
  FOLDER_ID=$2
  ycp --profile "${PROFILE?}" resource-manager folder update-access-bindings -r - <<<"
          {access_binding_deltas: [
            {action: ADD, access_binding:
              {
                role_id: internal.resource-manager.systemResourcesDeleter,
                subject: {type: serviceAccount, id: yc.iam.reaper}
              }
            }
          ], resource_id: ${FOLDER_ID?}, private_call: true}"
}

function delete_folder() {
  PROFILE=$1
  FOLDER_ID=$2
  echo "env $PROFILE folder $FOLDER_ID"
  ./duty/delete_folder_from_whitelisted_cloud.sh $PROFILE $FOLDER_ID
#  ./list-folder-resources.sh $PROFILE $FOLDER_ID
}

#for f in $folders_preprod; do
#  delete_folder preprod $f
#done
#
#for f in $folders_prod; do
#  delete_folder prod $f
#done

for f in $folders_kz; do
  delete_folder kz $f
done