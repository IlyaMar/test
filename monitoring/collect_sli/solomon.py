
import os
import logging


import config


logger = logging.getLogger(__name__)

os.environ['REQUESTS_CA_BUNDLE'] = '/etc/ssl/certs/ca-certificates.crt'

class Solomon:

    def __init__(self, host, iam_token):
        self.project_id = "yc.iam.service-cloud"
        global g_monitoring_host_preprod, g_iam_token
        self.host = host
        self.iam_token = iam_token

    def get_project_url(self):
        return "%s/api/v2/projects/%s" % (self.host, self.project_id)

    def get_api_url(self):
        return "%s/api/v2" % self.host

    def get_headers(self):
        return {
            "Content-Type": "application/json;charset=UTF-8",
            "Authorization": "Bearer %s" % self.iam_token
        }

