PROFILE=prod
export YC_IAM_TOKEN=$(ycp --profile "${PROFILE?}" iam iam-token create-for-subject --subject-id yc.iam.service-account)



ycp --profile=${PROFILE?} iam resource-type update-access-bindings -r - <<REQ
resource_type: organization-manager.application
access_binding_deltas:
- action: REMOVE
  access_binding:
    role_id: internal.iam.accessBindings.admin
    subject:
      id: yc.iam.org-service
      type: serviceAccount
REQ


PROFILE=testing
ycp --profile=${PROFILE?} resource-manager folder update-access-bindings -r - <<REQ
resource_id: yc.iam.service-folder
access_binding_deltas:
- action: REMOVE
  access_binding:
    role_id: editor
    subject:
      id: yc.iam.access-service
      type: serviceAccount
- action: REMOVE
  access_binding:
    role_id: editor
    subject:
      id: yc.iam.control-plane
      type: serviceAccount
- action: REMOVE
  access_binding:
    role_id: editor
    subject:
      id: yc.iam.openid-server
      type: serviceAccount
- action: REMOVE
  access_binding:
    role_id: editor
    subject:
      id: yc.iam.org-service
      type: serviceAccount
- action: REMOVE
  access_binding:
    role_id: editor
    subject:
      id: yc.iam.quota-manager
      type: serviceAccount
- action: REMOVE
  access_binding:
    role_id: editor
    subject:
      id: yc.iam.reaper
      type: serviceAccount
- action: REMOVE
  access_binding:
    role_id: editor
    subject:
      id: yc.iam.token-service
      type: serviceAccount
REQ


ycp --profile=${PROFILE?} iam gizmo update-access-bindings -r - <<REQ
access_binding_deltas:
- action: REMOVE
  access_binding:
    role_id: internal.organization-manager.agent
    subject:
      id: yc.iam.org-service
      type: serviceAccount
REQ


ycp --profile=${PROFILE?} iam root update-access-bindings -r - <<REQ
access_binding_deltas:
- action: REMOVE
  access_binding:
    role_id: iam.viewer
    subject:
      id: yc.iam.rm-control-plane
      type: serviceAccount
- action: REMOVE
  access_binding:
    role_id: organization-manager.viewer
    subject:
      id: yc.iam.rm-control-plane
      type: serviceAccount
REQ


ycp --profile=${PROFILE?} iam root update-access-bindings -r - <<REQ
access_binding_deltas:
- action: REMOVE
  access_binding:
    role_id: internal.iam.agent
    subject:
      id: yc.iam.service-account
      type: serviceAccount
- action: REMOVE
  access_binding:
    role_id: internal.sessionService
    subject:
      id: yc.iam.service-account
      type: serviceAccount
- action: REMOVE
  access_binding:
    role_id: internal.openid-server.agent
    subject:
      id: yc.iam.service-account
      type: serviceAccount
REQ



ycp --profile=internal-dev-terraform iam root update-access-bindings -r - <<REQ
access_binding_deltas:
- action: ADD
  access_binding:
    role_id: organization-manager.onCall
    subject:
      id: yc.iam.terraform
      type: serviceAccount
REQ

ycp --profile=internal-dev-terraform iam access-binding update-access-bindings -r - <<REQ
resource_id: root
resource_path:
  - resource_id: root
    resource_type: root
resource_type: root
access_binding_deltas:
- action: ADD
  access_binding:
    role_id: organization-manager.onCall
    subject:
      id: yc.iam.terraform
      type: serviceAccount
REQ



ycp --profile=prod resource-manager cloud update-access-bindings -r - <<REQ
resource_id: ${RESOURCE_ID?}
access_binding_deltas:
- action: ADD
  access_binding:
    role_id: admin
    subject:
      id: yc.iam.service-account
      type: serviceAccount
REQ
