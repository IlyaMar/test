PROFILE=doublecloud-aws-preprod
FOLDER_ID=yc.platform.controlPlane
ycp --profile "${PROFILE?}" --impersonate-service-account-id yc.iam.serviceAccount resource-manager folder update-access-bindings -r - <<<"
        {access_binding_deltas: [
          {action: ADD, access_binding:
            {
              role_id: internal.resource-manager.systemResourcesDeleter,
              subject: {type: serviceAccount, id: yc.iam.reaper}
            }
          }
        ], resource_id: ${FOLDER_ID?}, private_call: true}"


YC_IAM_TOKEN=$(
    ycp --profile "${PROFILE?}" --impersonate-service-account-id yc.iam.serviceAccount \
        iam iam-token create-for-subject --subject-id yc.iam.reaper
) ycp --profile "${PROFILE?}" \
    resource-manager folder delete --id "${FOLDER_ID?}" --async -r - \
    <<< "{delete_after: $(date --date "+1 day" --utc '+%FT%TZ')}"



YC_IAM_TOKEN=$(ycp --profile ${YCP_PROFILE?} iam iam-token create-for-subject --subject-id yc.iam.serviceAccount)  ycp --profile "${PROFILE?}" resource-manager cloud update-access-bindings -r - <<<"
        {access_binding_deltas: [
          {action: ADD, access_binding:
            {
              role_id: internal.resource-manager.systemResourcesDeleter,
              subject: {type: serviceAccount, id: yc.iam.reaper}
            }
          }
        ], resource_id: ${CLOUD_ID?}, private_call: true}"


YC_IAM_TOKEN=$(
    ycp --profile ${PROFILE?} --impersonate-service-account-id yc.iam.serviceAccount \
        iam iam-token create-for-subject --subject-id yc.iam.reaper
) ycp --profile ${PROFILE?} resource-manager cloud delete --id ${CLOUD_ID?} --async -r - <<< "{delete_after: $(date --date "+1 day " --utc '+%FT%TZ')}"