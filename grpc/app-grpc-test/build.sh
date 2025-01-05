source ../common.sh

VER=1.5
IMAGE=${CR?}/iam-idp-test-grpc:${VER?}
docker build . -t $IMAGE
#docker run -p 5001:5001 -v ~/secrets-app-test:/etc/yc/idp-data-plane -it $IMAGE bash
docker push       ${IMAGE?}

