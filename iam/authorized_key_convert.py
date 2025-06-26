import yaml
import json
import sys


def replace_space(s):
    return s.replace("\n", "\\n")
    

def convert_yaml_to_json(yaml_content):
    # Load YAML content
    yaml_data = yaml.safe_load(yaml_content)

    s = replace_space(yaml_data["key"]["public_key"])
    # print(s)

    # Extract necessary fields and join multiline strings
    json_data = {
        "id": yaml_data["key"]["id"],
        "service_account_id": yaml_data["key"]["service_account_id"],
        "key_algorithm": yaml_data["key"]["key_algorithm"],
        "public_key": yaml_data["key"]["public_key"],
        "private_key": yaml_data["private_key"]
    }

    return json.dumps(json_data, indent=2)

def read_file_to_string(file_path):
    try:
        with open(file_path, 'r') as file:
            content = file.read()
        return content
    except FileNotFoundError:
        raise Exception(f"The file {file_path} does not exist.")

# Example YAML content
yaml_content = read_file_to_string(sys.argv[1])

# Convert YAML to JSON
json_content = convert_yaml_to_json(yaml_content)
print(json_content)
