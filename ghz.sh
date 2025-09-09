/Users/ilya-martynov/sources/ghz/dist/ghz

IAM_TOKEN=$(ycp --profile=prod iam create-token) 
grpcurl  

ghz --call grpc.health.v1.Health/Check \
  as-overlay.private-api.cloud.yandex.net:4286



ghz -c 100 -n 1000000 --insecure \
  --proto helloworld/helloworld.proto \
  --call yandex.cloud.priv.servicecontrol.v1.AccessService/Authenticate \
  -d "{\"iam_token\":\"${IAM_TOKEN?}\"}" \
  iam-as-overlay-vla1.svc.cloud.yandex.net:4286




ghz -c 100 -n 1000000 --insecure \
  --proto helloworld/helloworld.proto \
  --call helloworld.Greeter.SayHello \
  -d '{"name":"Joe"}' \
  localhost:50051