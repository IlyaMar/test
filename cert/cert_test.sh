curl -v --connect-to auth.idp.iam.cloud.yandex.net:5001:localhost:5001 https://auth.idp.iam.cloud.yandex.net:5001

openssl s_client -connect localhost:5001 -servername auth.idp.iam.cloud.yandex.net
