# Update federation https://st.yandex-team.ru/CLOUD-219282

export CERT='-----BEGIN CERTIFICATE-----
MIIDQzCCAiugAwIBAgIUU84EtgS88PopoOF11vr5J1HfYXQwDQYJKoZIhvcNAQEL
BQAwMzExMC8GA1UEAwwoQURGUyBTaWduaW5nIC0gc3NvLnlhbmRleC10ZWFtLnJ1
IC0gMjAzMjAeFw0yMzA4MTcwOTI1NDZaFw0zMjA4MTQwOTI1NDZaMDMxMTAvBgNV
BAMMKEFERlMgU2lnbmluZyAtIHNzby55YW5kZXgtdGVhbS5ydSAtIDIwMzIwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/cSxNWYKrtdQGS05PVUBuugc+
pBPXqdgyY/XAcCY3grnmre8YO8iuHzeX1ToBLS1L8D66qUiFCPAnxBzLE2qWmnHR
EFBaMRVKyTDzJ8ddStsEgC2te3WF50q7ntlFJ55BOI11/pBDLODxuYg6+TIVuTGb
JdwgWe7awMxp69edxY+U4fdFk7lOU5lsfH8MCkG6iEEuz5bf5jKIjFk1b2QIMhOk
EwhVP9ksNOHYG3B2c3xqf6wxuWu07DCqfiA7UmAeb1Ea4gqVL1M7Rg69MVf0JLbZ
7l3xbpcViZbZHhLIAzLybPJ7YSquqNBHqnquH1KVOmLvfGTV3+Yl4yXGtL5fAgMB
AAGjTzBNMAsGA1UdDwQEAwIEkDAdBgNVHQ4EFgQU7/7oc2uGYoEz6MbuhhTtFTox
iyQwHwYDVR0jBBgwFoAU7/7oc2uGYoEz6MbuhhTtFToxiyQwDQYJKoZIhvcNAQEL
BQADggEBAFuJ9hYVRL7e4EZS2XgDg9ZT3hX3qL7l0M3UxpEP3C4SVsfohZPs40bG
/A995V6+MlSb3sdRiORwLjWA1qPUNXODtNieamD2QysJXRBDmyzY1fHiqfn+gkLB
ZFD3OJsuorVSfklqQDg+azPvsUx0tdOVGINP6Z2D5kZkevdwd6PhKFnk6eh9iW4E
EmRb5K/nbkBfln0XdOZwHLpw+4ISwIRENLbQU/pO2qaHq8xUc6BMYBu6X1vTF8rg
wY19f/HoYfZ2um5iB7j8mOpvlHzpTZHxFDBPH2XoRm1t1RNCJsrrs8jME99B3VaC
KAaDLrThnVn7/kRWmtgftjX8eHD+Mkc=
-----END CERTIFICATE-----'

ycp --profile doublecloud-aws-prod --impersonate-service-account-id yc.iam.service-account organization-manager saml certificate create --federation-id yc.yandex-team.federation --name="signing-2025" --description="cert 2025 ORION-4337" --data="${CERT}"


UPDATE='{"issuer":"http://sso.yandex-team.ru/adfs/services/trust", "sso_url":"https://sso.yandex-team.ru/adfs/ls/", "update_mask": {"paths": ["issuer", "sso_url"] }}'

ycp --profile doublecloud-aws-prod --impersonate-service-account-id yc.iam.service-account organization-manager saml federation update --id=yc.yandex-team.federation -r- <<< "${UPDATE?}"

