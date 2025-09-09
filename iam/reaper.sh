ycp --impersonate-service-account-id yc.iam.service-account --profile ${PROFILE?} maintenance reaper task-processor \
task search DeleteCloudJob#<Operation id>

# cloud status
$list_join = ($l) -> { return Unicode::JoinFromList(ListSort($l), ', '); };
select status, restrictions, count(*) as cnt, $list_join(agg_list(id, 10)) as cloud_ids
from (
    select c.cloud_id as id, some(c.cloud_status) as status, $list_join(agg_list(r.restriction_type_id)) as restrictions
    from (
        select c.id as cloud_id, 'resource-manager.cloud'u as resource_type, c.status as cloud_status
        from `hardware/default/identity/r3/clouds` as c
    ) c
        left join `iam/restrictions/restrictions` as r
            on r.resource_type = c.resource_type and r.resource_id = c.cloud_id
    group by c.cloud_id
)
group by status, restrictions
order by status, restrictions


# folder status
$list_join = ($l) -> { return Unicode::JoinFromList(ListSort($l), ', '); };
select status, restrictions, count(*) as cnt, $list_join(agg_list(id, 10)) as cloud_ids
from (
    select c.cloud_id as id, some(c.cloud_status) as status, $list_join(agg_list(r.restriction_type_id)) as restrictions
    from (
        select c.id as cloud_id, 'resource-manager.folder'u as resource_type, c.status as cloud_status
        from `hardware/default/identity/r3/folders` as c
    ) c
        left join `iam/restrictions/restrictions` as r
            on r.resource_type = c.resource_type and r.resource_id = c.cloud_id
    group by c.cloud_id
)
group by status, restrictions
order by status, restrictions



YCP_PROFILE=preprod
IAM_TOKEN=$(ycp --profile ${YCP_PROFILE?} iam iam-token create-for-service-account --subject-id yc.iam.service-account)
# Список шардов фолдера
curl -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -H "X-Request-ID: ${REQUEST_ID}" \
    -s -v https://solomon.cloud-prod.yandex-team.ru:443/api/v2/projects/${FOLDER_ID}/shards/ \
    | jq
# Удаление шарда
curl -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -H "X-Request-ID: ${REQUEST_ID}" \
    -s -v -X DELETE https://solomon.cloud-prod.yandex-team.ru:443/api/v2/projects/${FOLDER_ID}/shards/${FOLDER_ID}_${SHARD_ID} \
    | jq
# Удаление кластера
curl -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -H "X-Request-ID: ${REQUEST_ID}" \
    -s -v -X DELETE https://solomon.cloud-prod.yandex-team.ru:443/api/v2/projects/${FOLDER_ID}/clusters/${FOLDER_ID}_${CLUSTER_ID} \
    | jq