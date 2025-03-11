%%
KUBECONFIG=/etc/yc/bootstrap/kubeconfig kubectl --context testing-a patch saltformula -n iam compute-iam-oslogin-daemon \
--type='json' -p '[{"op": "replace", "path": "/spec/suspend", "value": false}]'
%%

#find skipped node

comm -23 <(KUBECONFIG=/etc/yc/bootstrap/kubeconfig kubectl --context preprod-c -n iam get nodes --no-headers -l bootstrap.cloud.yandex.net/baseRole=compute | sed 's/.cloud.yandex.*//g' | sort) <(KUBECONFIG=/etc/yc/bootstrap/kubeconfig kubectl saltformula --context preprod-c -n iam get compute-iam-oslogin-daemon | grep Job | sed 's/-compute-iam-oslogin-daemon.*//g' |  sed 's/.*myt/myt/g' | sort | uniq)

CONTEXT=prod-a
comm -23 <(kubectl --context ${CONTEXT?} -n iam get nodes --no-headers -l bootstrap.cloud.yandex.net/baseRole=compute | sed 's/.cloud.yandex.*//g' | sort) <(kubectl saltformula --context ${CONTEXT?} -n iam get compute-iam-oslogin-daemon | grep Job | sed 's/-compute-iam-oslogin-daemon.*//g' |  sed 's/.*vla/vla/g' | sort | uniq)

