
check() {
    for host in $(pssh list 'x@iam-ya-*.svc.cloud.yandex.net'); do
        pssh run --cause other:check "keytool -list -keystore /etc/yc/rm-control-plane/truststore | grep yandex-cloud-ul7" $host
    done

}


check preprod 