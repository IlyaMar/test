
#IMAGE=iam-k8s-infra:35
IMAGE=iam-idp-test-grpc:1.5

docker pull cr.yandex/yc-iam/$IMAGE
docker tag cr.yandex/yc-iam/$IMAGE cr.cloud-preprod.yandex.net/crtqchh33vmh7gjrr5uq/$IMAGE
docker push cr.cloud-preprod.yandex.net/crtqchh33vmh7gjrr5uq/$IMAGE





docker run cr.cloud-preprod.yandex.net/crtqchh33vmh7gjrr5uq/iam-focal-service:latest
yc container docker-credential get