OLD_FED_ID=bpf24pu9mcmr71t6da8p
PROFILE=prod


~/arcadia/cloud/iam/scripts/federation-list-user-roles.sh $OLD_FED_ID $PROFILE > users.json


#import 11.09
#https://st.yandex-team.ru/CLOUDSUPPORT-91640#61291492398ae13e7405d943
#исходный домен sbermarket.ru , целевой kuper.ru

~/arcadia/cloud/iam/scripts/federation-copy-users-and-roles.sh sbermarket.ru kuper.ru < users.json

