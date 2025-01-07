
cat > 1.sql
select * from `iam/access_bindings` where subject_id is null or role_slug is null or
subject_type is null or not (subject_type in ('userAccount', 'federatedUser', 'serviceAccount', 'invitee', 'group', 'system'))


ydb -e ${YDB_ENDPOINT?} -d ${YDB_DATABASE?} table query execute -t scan -f 1.sql
ydb  yql -t scan -f 1.sql


SELECT tg, COUNT(DISTINCT id) FROM `/global/iam/iam/subjects`
GROUP BY JSON_VALUE(CAST(settings AS JSON), "$.telegramChatName") IS NOT NULL AS tg;


SCRIPT='--!syntax_v1
select id, key_algorithm, key_type, cloud_id, subject_type, subject_id
from `hardware/default/identity/r3/token_public_keys`
where key_type in ("service", "skeleton");
'
ydb --endpoint "${YDB_ENDPOINT?}" --database "${YDB_DATABASE?}" scripting yql --script "${SCRIPT?}"

cat > 1.sql << 'END'
--!syntax_v
select * from `hardware/default/identity/r3/clouds_history` where id = "yc.imaginarium_cloud";
END
ydb --endpoint "${YDB_ENDPOINT?}" --database "${YDB_DATABASE?}" scripting yql --file 1.sql

SCRIPT='--!syntax_v1
select id, key_algorithm, key_type, cloud_id, subject_type, subject_id
from `hardware/default/identity/r3/token_public_keys`
where key_type in ("service", "skeleton");
'
tsh ssh -t jumphost.iam.internal.yadc.tech "IAM_TOKEN=${IAM_SA_TOKEN} SCRIPT='$SCRIPT' ydb -e grpcs://iam.aws-frankfurt-preprod.ydb.yadc.tech:2135 -d /pre-prod_aws-frankfurt/iam yql --format json-unicode -s '$SCRIPT' | jq ."

ydb --endpoint "${YDB_ENDPOINT?}" --database "${YDB_DATABASE?}" table read --columns id,status --format json-unicode  hardware/default/identity/r3/clouds | jq -rc 'select(.status == "ACTIVE") | .id' > clouds_active_preprod.txt

