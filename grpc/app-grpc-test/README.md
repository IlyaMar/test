# Doc
Test application. Exposes grpc with tls.

# Reference
https://grpc.io/docs/languages/python/basics/
https://github.com/grpc/grpc/blob/v1.66.0/examples/python/route_guide/route_guide_server.py


# Call
```
grpcurl -import-path=. -proto route_guide.proto -plaintext -d '{"latitude": 1, "longitude": 2}' localhost:5000 routeguide.RouteGuide/GetFeature
grpcurl -import-path=. -proto=route_guide.proto            -d '{"latitude": 1, "longitude": 2}' auth.idp.iam.cloud.yandex.net:443 routeguide.RouteGuide/GetFeature
```
TLS is on port 5001
