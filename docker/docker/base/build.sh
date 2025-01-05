source ../common.sh

VER=1.0
NAME=iam-idp-test-base
IMAGE=${CR?}/${NAME?}:${VER?}
docker build . -t $IMAGE
#docker run $IMAGE nc -4zv payload.lockbox.api.cloud.yandex.net 443
#docker push       cr.yandex/crpacdetsu8hcv118m0j/${NAME?}:${VER?}

