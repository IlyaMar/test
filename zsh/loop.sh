for n in {1..10}; do echo start $n; done



# pssh run --cause other:check "ls /etc/yc/enginfra-locallb-agent/certs/ca/ul7-ca.crt" $host

for host in $(pssh list 'x@iam-ya-*.svc.cloud.yandex.net'); do
    pssh run --cause other:check "keytool -list -keystore /etc/yc/rm-control-plane/truststore | grep yandex-cloud-ul7" $host
done

rm-cp y