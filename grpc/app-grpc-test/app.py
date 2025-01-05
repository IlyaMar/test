from concurrent import futures
import logging
import sys
import grpc
import route_guide_pb2
import route_guide_pb2_grpc
# import route_guide_resources

log = logging.getLogger(__name__)

# RouteGuideServicer provides an implementation of the methods of the RouteGuide service.
class RouteGuideServicer(route_guide_pb2_grpc.RouteGuideServicer):
    def GetFeature(self, request, context):
        logging.debug("get feature %s" % request)
        return route_guide_pb2.Feature(name="test", location=request)

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=3))
    route_guide_pb2_grpc.add_RouteGuideServicer_to_server(
        RouteGuideServicer(), server
    )
    logging.info("starting")

    keyfile = '/etc/yc/idp-data-plane/tls.key'
    certfile = '/etc/yc/idp-data-plane/tls.crt'
    with open(keyfile, 'rb') as file:
        private_key_bytes = file.read()
    with open(certfile, 'rb') as file:
        certificate_chain_bytes = file.read()
    credentials = grpc.ssl_server_credentials(
        [(private_key_bytes, certificate_chain_bytes)]
    )
    server.add_secure_port('[::]:5001', credentials)
    logging.info("tls creds read")

    server.add_insecure_port("[::]:5000")
    server.start()
    logging.info("started")
    server.wait_for_termination()


if __name__ == "__main__":
    logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)
#     logging.basicConfig()
#     handler = logging.StreamHandler(sys.stdout)
#     root = logging.getLogger()
#     root.setLevel(logging.DEBUG)
#     root.addHandler(handler)
    serve()
