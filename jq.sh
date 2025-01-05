pssh run "cat /var/log/yc/token-service/events.log | jq 'select(.authentication.subject_id==\"d26ekeg4oqsvtr4321es\" and .event_status==\"ERROR\")' " x@iam-ts-*.svc.cloud-testing.yandex.net
cat access.log | jq 'select(.type=="HTTP" and .request_uri!="/ping" and (.request_headers | .["x-forwarded-for"]) and (.request_headers.cookie | select(. != null) | contains("Session_id")) )' | less

jq 'select(.type=="HTTP" and .request_uri!="/ping" )'
