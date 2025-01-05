

ydb -e ${YDB_ENDPOINT?} -d ${YDB_DATABASE?} yql -f /tmp/db-migrations/2024-04-24-resource-containter-state-index.sql
