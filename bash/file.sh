cat > ~/.aws/credentials1 <<REQ
[iam-terraform-cloud]
aws_access_key_id = ${ACCESS_KEY?}
aws_secret_access_key = ${SECRET_KEY?}
REQ


set --export DISPLAY (cat ~/.display.txt)