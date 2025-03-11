# https://docs.yandex-team.ru/iam-playbook-operation/duty/organization_manager#kakie-byvayut-kvoty,-svyazannye-s-organizaciyami,-i-gde-oni-zhivut


CLOUD_ID=yc.iam.service-cloud
PROFILE=preprod
ycp --profile ${PROFILE?} --impersonate-service-account-id yc.iam.service-account iam quota-limit get -r - <<REQ
resource:
  resource_id: $CLOUD_ID
  resource_type: resource-manager.cloud
REQ

# quotas: iam.accessBindings.count, iam.authorizedKeys.count
PROFILE=internal-prestable
CLOUD_ID=a8bbuojugvjbl1d1ve7g
ycp --profile ${PROFILE?} --impersonate-service-account-id yc.iam.service-account iam quota-limit update -r - <<REQ
resource:
  resource_id: $CLOUD_ID
  resource_type: resource-manager.cloud
limit:
  quota_id: iam.accessBindings.count
  limit: 1000000
REQ


PROFILE=prod
ycp --profile ${PROFILE?} --impersonate-service-account-id yc.iam.service-account organization-manager quota-limit update -r - <<REQ
resource:
  resource_id: bfbp5u6j56dcfoirk8pp
  resource_type: iam.userAccount
limit:
  quota_id: organization-manager.organizations.count
  limit: 10000
REQ

PROFILE=prepprod
ycp --profile ${PROFILE?} --impersonate-service-account-id yc.iam.service-account organization-manager quota-limit update -r - <<REQ
resource:
  resource_id: yc.iam.service-cloud
  resource_type: resource-manager.cloud
limit:
  quota_id: vpc.ipv6Addresses.count
  limit: 5
REQ
