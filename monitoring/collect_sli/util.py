import json

def serialize_labels(labels):
    return json.dumps(labels, separators=(',', ':'))

def deserialize_labels(labels_string):
    return json.loads(labels_string)
