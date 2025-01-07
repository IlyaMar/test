for f in {1..10}; do

curl 'https://solomon.cloud.yandex-team.ru/api/v2/projects/yc.iam.service-cloud/sensors/labels?limit=10000&names=cluster&selectors=%7Bcluster%3D%22*%22%2C%20cpu%3D%220%22%2C%20path%3D%22%2FSystem%2FUserTime%22%2C%20project%3D%22yc.iam.service-cloud%22%2C%20service%3D%22SYS%22%7D' \
  -H 'accept: application/json' \
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
  -H 'x-yandex-login: ya'

done


# 23 sec