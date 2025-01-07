export HELM_REGISTRY_CONFIG=~/.docker/config.json

helm pull --version 105543  oci://cr.yandex/crpb27ur8r606mfu5f7v/charts/iam-idp-auth-service

helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/external-secrets/chart/external-secrets --version 0.9.20 --untar

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
