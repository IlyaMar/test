#!/bin/bash -e

start_dir="$1"
env="$2"

if [ ! -d "$start_dir" ]; then
  echo "Directory $start_dir does not exist."
  exit 1
fi


function process {
  echo "Running command in $1"
  (
    cd $1
    # YCP_PROFILE=$env terraform init -backend-config="secret_key=$(ya vault get version sec-01ewn2b4vf3vmj18c65w1b8wh6 -o AccessSecretKey)" 
    YCP_PROFILE=$env terraform init
    terraform state replace-provider -auto-approve terraform.storage.cloud-preprod.yandex.net/yandex-cloud/ycp ycp-terraform.storage.yandexcloud.net/yandex-cloud/ycp
  )
}


find "$start_dir" -type d | while read -r dir; do
  if [ -f "$dir/provider.tf" ]; then
    echo "Found provider.tf in $dir"
    process $dir
  fi
done
