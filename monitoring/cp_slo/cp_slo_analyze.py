import csv
import os
from string import Template
import re
import hashlib


# columns:
# method, max, min, avg
# avg is rps
def read_csv(file_name):
    current_directory = os.path.dirname(os.path.abspath(__file__))
    file_path = os.path.join(current_directory, file_name)

    filtered_rows = []
    
    with open(file_path, 'r', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            filtered_rows.append(row)
                
    return filtered_rows


# prod-iam-control-plane-error-slo-federation-listaccessbindings-1h
# prod-iam-control-plane-error-slo-yandexpasspo28da832d84deb0e95-1d
# authenticationcontextclassreference-list

def replace_shorten_terms(s):
    r = [
        ("credential", "cred"),
        ("federation", "fed"),
        ("federated", "fed"),
        ("accessbinding", "ab"),
        ("accessbindings", "ab"),
        ("servicecontrol", "sc"),
        ("serviceaccount", "sa"),
    ]
    for old, new in r:
        s = s.replace(old, new)
    return s


def shortn_with_hash(s):
    # leave 28 characters
    if len(s) <= 28:
        return s
    n = 12
    start = s[:n]
    end = s[n:]
    return start + hashlib.sha256(s.encode()).hexdigest()[:28-12]



def shorten_grpc_method(full_method):
    # Split into service and method parts
    service_part, method_part = full_method.split('/')
    
    # Process service name
    service_name = service_part.split('.')[-1]      # Get last part after dot
    service_name = re.sub(r"Service$", "", service_name)  # Remove last Service
    service_name = service_name.lower()             # Convert to lowercase
    
    # Process method name
    method_name = method_part.lower()               # Convert to lowercase
    
    # Shorten method name by taking only the verb part
    # verbs = {'list', 'get', 'create', 'update', 'delete', 'add', 'remove', 'set', 'grant', 'revoke'}
    # for verb in verbs:
    #     if method_name.startswith(verb):
    #         method_name = verb
    #         break
    
    return shortn_with_hash(replace_shorten_terms(f"{service_name}-{method_name}"))



def print_error_slo_config_method(line):
    t_method = """            "$short" = {method = "$method", slo = 99.99, host = "iam-*"},
"""
    t_template = Template(t_method)
    
    method_short = shorten_grpc_method(line['method'])

    return t_template.safe_substitute({
        "short": method_short,
        "method": line['method'],
    })


def print_error_slo_config(method_prefix, data):
    methods = filter(lambda m: m["method"].startswith(method_prefix), data)

    method_configs = map(print_error_slo_config_method, methods)
    joined_method_configs = "".join(method_configs)

    t = """
        error_slo = {
$method_configs
        }

"""
    return Template(t).safe_substitute({
        "method_configs": joined_method_configs,
    })



# Example usage
cp_rps_data = read_csv('cp_rps.csv')

s = print_error_slo_config("organizationmanager.v1.", cp_rps_data)
print(s)