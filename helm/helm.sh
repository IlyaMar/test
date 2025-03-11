# login
helm registry login cr.cloud-preprod.yandex.net -u iam    # enter iam token
cat sa-ic-key.json | helm registry login cr.yandex --username 'json_key' --password-stdin


export HELM_REGISTRY_CONFIG=~/.docker/config.json



helm pull --version 105543  oci://cr.yandex/crpb27ur8r606mfu5f7v/charts/iam-idp-auth-service
helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/external-secrets/chart/external-secrets --version 0.9.20 --untar
helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/yc-alb-ingress/yc-alb-ingress-controller-chart --version v0.2.15 --untar
helm pull oci://cr.yandex/crp9j326k6up539jsjlm/charts/infra/unified-agent --version 41806-c99bac973a3 --untar



helm install --namespace eso --create-namespace --set-file auth.json=sa-eso-key.json external-secrets ./external-secrets/


cat sa-ic-key.json | helm registry login cr.yandex --username 'json_key' --password-stdin && \
helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/yc-alb-ingress/yc-alb-ingress-controller-chart \
  --version v0.2.11 \
  --untar && \
KUBECONFIG=.kubeconfig_idp-prod helm install \
  --namespace yc-alb-ingress \
  --create-namespace \
  --set folderId=${FOLDER_ID?} \
  --set clusterId=${CLUSTER_ID?} \
  --set enableDefaultHealthChecks=true \
  --set-file saKeySecretKey=sa-ic-key.json \
  yc-alb-ingress-controller ./yc-alb-ingress-controller-chart/



# backup
helm get values -o yaml app > values_bak.yaml
helm upgrade app ~/arcadia/cloud/iam/terraform/idp/modules/application/iam-idp-auth-service/app/helm --set javaOptions.xmx=2G --reuse-values
helm upgrade --set javaOpts.xmx=2G grafana grafana/grafana --version grafana-6.12.1

# Hotfix
helm get values -o yaml app > values_bak.yaml
CR=cr.cloud-preprod.yandex.net/crtqchh33vmh7gjrr5uq
helm pull oci://$CR/charts/iam-idp-auth-service --version 136161
helm upgrade app-ru-central1-a-1 iam-idp-auth-service-136161.tgz --set javaOptions.xmx=2G --reuse-values
helm upgrade app-ru-central1-a-1 iam-idp-auth-service-136161.tgz  -f values_bak.yaml

helm upgrade app-ru-central1-a-1 https://cr.cloud-preprod.yandex.net/crtqchh33vmh7gjrr5uq/charts/iam-idp-auth-service-136161.tgz --set javaOptions.xmx=2G --reuse-values
