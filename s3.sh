ycp --profile=prod storage v1 bucket update -r - <<REQ
versioning: VERSIONING_ENABLED
name: iam-terraform-state
update_mask:
  paths:
    - versioning
REQ
