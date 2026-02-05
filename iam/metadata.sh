
ycp --profile=prod iam tools get-minimal-role --permission-id resource-manager.clouds.get
ycp --profile=prod iam tools get-role-tree --role-id viewer
ycp --profile=prod iam tools list-roles --permission-id compute.osLogin.users.get
ycp --profile=prod iam tools list-roles --permission-id iam.root.updateAccessBindings


ycp --profile=s3preprod iam permission get s3.infra.cmsWrite
ycp --profile ${PROFILE?} iam role get -r - <<< "role_id: audit-trails.configViewer"
