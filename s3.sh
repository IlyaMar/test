ycp --profile=prod storage v1 bucket update -r - <<REQ
versioning: VERSIONING_ENABLED
name: iam-terraform-state
update_mask:
  paths:
    - versioning
REQ



export S3_CREDS_LOCKBOX_ID=${S3_CREDS_LOCKBOX_ID:-e6qc4drd44c2484h2mg5}

export S3_AWS_PROFILE=${S3_AWS_PROFILE:-iam-metadata-release}
export S3_ENDPOINT=${S3_ENDPOINT:-https://s3.mds.yandex.net}
export S3_BUCKET=${S3_BUCKET:-iam}
S3_PATH="$S3_BUCKET/dump/"
S3_TARGET="s3://$S3_PATH"
YCS3_CMD="aws --profile $S3_AWS_PROFILE --endpoint-url $S3_ENDPOINT s3"
$YCS3_CMD cp as32G.gz $S3_TARGET/
