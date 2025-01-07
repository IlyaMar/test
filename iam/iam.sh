curl https://auth.yandex.cloud/oauth/userinfo -H "Authorization: Bearer $(ycp --profile prod iam create-token)"


ycp --profile prod oauth claim get --subject-ids ajele9dp0oc631ihg4t0

ycp --profile prod --impersonate-service-account-id yc.iam.serviceAccount maintenance access-service dynamic-values get-all-values
