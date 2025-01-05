source ../common.sh


VER=1.1
IMAGE=${CR?}/app-metrics:${VER?}
docker build . -t $IMAGE
#docker run -p 8000:8000 $IMAGE
docker push  $IMAGE

