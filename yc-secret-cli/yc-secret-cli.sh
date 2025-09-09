https://wiki.yandex-team.ru/cloud/infra/secret-service/cli/
https://s3.mds.yandex.net/yc-bootstrap-lts/logs/task_diffs/yc-b-lq9697u5c6o0shvv7.salt_result

PROFILE=prod
yc-secret-cli secret add --profile prod --name clickhouse-iam-logs-password-prod --file clickhouse_iam_logs_password.txt
SECRET_ID=1df83c3e-beb6-11ee-9a3f-b40aca696c91
yc-secret-cli --profile ${PROFILE?} hostgroup add-secret bootstrap_base-role_${PROFILE?}_iam-access-service --secret-id ${SECRET_ID?}
yc-secret-cli --profile ${PROFILE?} hostgroup add-secret bootstrap_base-role_${PROFILE?}_iam-access-service-k8s --secret-id ${SECRET_ID?}

PROFILE=prod
F=yc-b-lq9697u5c6o0shvv7.salt_result
for SECRET_ID in ${(f)"$(grep -oE -- 't get info of secret with id [0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}' $F | awk '{print $8}' | sort | uniq)"}; do
echo "work with $SECRET_ID"
yc-secret-cli --profile ${PROFILE?} hostgroup add-secret bootstrap_base-role_${PROFILE?}_iam-access-service-overlay --secret-id ${SECRET_ID?}
yc-secret-cli --profile ${PROFILE?} hostgroup add-secret bootstrap_base-role_${PROFILE?}_iam-access-service-overlayk8s --secret-id ${SECRET_ID?}
done

yc-secret-cli hostgroup show bootstrap_base-role_prod_iam-access-service-overlay

yc-secret-cli hostgroup add-host bootstrap_base-role_prod_iam-access-service-overlay --fqdn iam-as-overlay-vla1.cloud.yandex.net