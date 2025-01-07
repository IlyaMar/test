query=$'histogram_percentile(as_vector(99, 99.9, 99.99, 100), \'le\', sum(non_negative_derivative(moving_avg(drop_nan(group_by_time(1m, \'avg\', {\'app\'=\'*_server\', \'cluster\'=\'preprod-iam-control-plane\', \'host\'=\'iam-cp-klg1\', \'method\'=\'*\', \'project\'=\'yc.iam.service-cloud\', \'sensor\'=\'grpc_durations\', \'service\'=\'iam-control-plane\'})), 5m))) by (le))","refId":"Q1","type":"timeserie"'

curl 'https://solomon.cloud-preprod.yandex-team.ru/rest/grafana/search' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: ru,en;q=0.9,bg;q=0.8' \
  -H 'content-type: application/json' \
  -H 'cookie: ...' \
  -H 'origin: https://grafana.yandex-team.ru' \
  -H 'priority: u=1, i' \
  -H 'referer: https://grafana.yandex-team.ru/' \
  -H 'sec-ch-ua: "Not/A)Brand";v="8", "Chromium";v="126", "YaBrowser";v="24.7", "Yowser";v="2.5"' \
  -H 'sec-ch-ua-arch: "x86"' \
  -H 'sec-ch-ua-bitness: "64"' \
  -H 'sec-ch-ua-full-version-list: "Not/A)Brand";v="8.0.0.0", "Chromium";v="126.0.6478.234", "YaBrowser";v="24.7.1.1120", "Yowser";v="2.5"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  -H 'sec-ch-ua-platform-version: "6.5.0"' \
  -H 'sec-ch-ua-wow64: ?0' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-site' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 YaBrowser/24.7.0.0 Safari/537.36' \
  --data-raw $'{"app":"dashboard","requestId":"Q101","timezone":"browser","panelId":5,"dashboardUID":"iam-duty-deploy","publicDashboardAccessToken":"","range":{"from":"2024-10-02T06:48:46.784Z","to":"2024-10-02T07:18:46.784Z","raw":{"from":"now-30m","to":"now"}},"timeInfo":"","interval":"2s","intervalMs":2000,"targets":[{"target":"'$query'}],"maxDataPoints":1019,"scopedVars":{"service":{"selected":true,"text":"IAM Control Plane","value":"iam-control-plane"},"__interval":{"text":"2s","value":"2s"},"__interval_ms":{"text":"2000","value":2000}},"startTime":1727853526784,"rangeRaw":{"from":"now-30m","to":"now"}}'

    #--data-raw $'{"app":"dashboard","requestId":"Q101","timezone":"browser","panelId":5,"dashboardUID":"iam-duty-deploy","publicDashboardAccessToken":"","range":{"from":"2024-10-02T06:48:46.784Z","to":"2024-10-02T07:18:46.784Z","raw":{"from":"now-30m","to":"now"}},"timeInfo":"","interval":"2s","intervalMs":2000,"targets":[{"target":"histogram_percentile(as_vector(99, 99.9, 99.99, 100), \'le\', sum(non_negative_derivative(moving_avg(drop_nan(group_by_time(1m, \'avg\', {\'app\'=\'*_server\', \'cluster\'=\'preprod-iam-control-plane\', \'host\'=\'iam-cp-klg1\', \'method\'=\'*\', \'project\'=\'yc.iam.service-cloud\', \'sensor\'=\'grpc_durations\', \'service\'=\'iam-control-plane\'})), 5m))) by (le))","refId":"Q1","type":"timeserie"}],"maxDataPoints":1019,"scopedVars":{"service":{"selected":true,"text":"IAM Control Plane","value":"iam-control-plane"},"__interval":{"text":"2s","value":"2s"},"__interval_ms":{"text":"2000","value":2000}},"startTime":1727853526784,"rangeRaw":{"from":"now-30m","to":"now"}}'
