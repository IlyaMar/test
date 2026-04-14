# get image from AW iam registry
VER=0.105402
docker pull cr.yandex/crpsh8lqvs5nupoi3v85/iam-idp-cp-application:$VER

docker tag cr.yandex/crpsh8lqvs5nupoi3v85/iam-idp-cp-application:$VER cr.yandex/crpb27ur8r606mfu5f7v/iam-idp-cp-application:$VER

# requires YC_TOKEN of iam sa
docker push cr.yandex/crpb27ur8r606mfu5f7v/iam-idp-cp-application:$VER
