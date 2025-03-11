import json
import logging
import requests

from solomon import Solomon
import util


g_solomon = Solomon()


def read_data(time_from, time_to, labels):
    global g_solomon
    selector = util.serialize_labels(labels).replace('"', "'").replace(':', '=')

    query = {
        "downsampling": {
            "disabled": True,
        },
        # taken range [from, to).
        "from": time_from * 1000,
        "to": time_to * 1000,
        "program": selector,
        "version": "BASIC_1"
    }
    dto = json.dumps(query)
    logger.debug("read metrics: %s", dto)
    resp = requests.post("%s/sensors/data" % g_solomon.get_project_url(), data=dto,
                         headers=g_solomon.get_headers())
    resp.raise_for_status()
    logging.debug("read metrics %d %d", resp.status_code, len(resp.content))
    resp_json = json.loads(resp.text)
    err = resp_json.get('errorsDetails')
    if err:
        raise Exception("errors %s" % err)
    # timeseries = list(map(lambda x: x["timeseries"], resp_json["vector"]))


def main():
    logging.basicConfig(level=logging.DEBUG)

main()