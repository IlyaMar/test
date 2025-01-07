
echo "{}" | java -jar /opt/polyglot.jar call --endpoint=localhost:4284 --full_method=yandex.cloud.priv.iam.v1.OsLoginService/Get
sudo -u my_service_name grpcurl --plaintext --unix /var/run/yc/token-agent/socket yandex.cloud.priv.iam.v1.TokenAgent/GetToken
grpcurl -plaintext -d '{"cloudId":"123"}' localhost:9055 yandex.cloud.priv.iam.v1.compute.OsLoginService/Get
grpcurl  -H "Authorization: Bearer ${SA_IAM_TOKEN?}" -d '{"cloud_id": "yc.iam.service-cloud"}' iam.private-api.cloud-testing.yandex.net:4283 yandex.cloud.priv.iam.v1.compute.OsLoginService/ListProfiles

grpcurl -H "Authorization: Bearer ${SA_IAM_TOKEN?}" -d ''{"access_binding_deltas":[{"action":"ADD","access_binding":{"role_id":"v","subject":{"id":"yc.iam.reaper","type":"serviceAccount"}}}],"private_call":true,"resource_path":[{"id":"yc.billing.wastebasket","type":"billing.account"}]}'' ops.private-api.iam.internal.double.tech:4283 yandex.cloud.priv.iam.v1.AccessBindingService/UpdateAccessBindings

RESOURCE_TYPE="resource-manager.folder" && \
RESOURCE_ID="yc.nbs.nbs-control" && \
PERMISSION=compute.osLogin.adminLogin && \
SUBJECT_ID=yc.nbs.nbs-oncall-sa && \
grpcurl \
  -d "{\"subject\":{\"service_account\":{\"id\":\"${SUBJECT_ID?}\"}},\"permission\":\"${PERMISSION?}\",\"resource_path\":[{\"id\":\"${RESOURCE_ID?}\",\"type\":\"${RESOURCE_TYPE?}\"}]}" \
  as.private-api.cloud-testing.yandex.net:4286 \
  yandex.cloud.priv.servicecontrol.v1.AccessService/Authorize
