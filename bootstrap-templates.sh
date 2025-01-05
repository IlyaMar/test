
export YC_IAM_TOKEN=
yc-bootstrap --templates-repo-branch=iam_mk8s --template prod.yaml --ticket-id CLOUD-215223  - provision-default-resources --resources-path iam/terraform
# --apply -