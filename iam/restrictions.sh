RM_CP_TOKEN=$(ycp --profile=preprod --impersonate-service-account-id yc.iam.service-account iam iam-token create-for-subject --subject-id  yc.iam.rm-control-plane)
YC_IAM_TOKEN=$RM_CP_TOKEN ycp --profile=preprod --impersonate-service-account-id yc.iam.service-account resource-manager folder list-restrictions  --resource-id aoed13imagmcglgptvgr

YC_IAM_TOKEN=$RM_CP_TOKEN ycp --profile=preprod iam restriction remove-if-present --resource-type resource-manager.folder --restriction-type-id blockPermissions.systemManaged --resource-id aoe30e9fg8ar56367oid
YC_IAM_TOKEN=$RM_CP_TOKEN ycp --profile=preprod iam restriction add-if-absent     --resource-type resource-manager.folder --restriction-type-id blockPermissions.systemManaged --resource-id aoe30e9fg8ar56367oid


