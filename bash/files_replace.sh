#!/bin/bash -eEu
set -o pipefail


function process_file() {
  file=$1
  echo "process $file"
  # file e g ./internal-dev/activeprobes-org/main.tf
  # need to convert to
  dir=`dirname $file`
  path_to_root=`realpath --relative-to=$dir /home/ilya-martynov/cloudia-terraform/cloud/deploy/bootstrap/templates`
  echo "relative path $path_to_root"

  sed -ri "s|source = \"git::ssh://git@bb.yandexcloud.net/cloud/bootstrap-templates.git//(.*)\?.*\"|source = \"$path_to_root/\1\"|" $file
  #> /tmp/f
  #mv /tmp/f $file

  # replace this:
  # source = "git::ssh://git@bb.yandexcloud.net/cloud/bootstrap-templates.git//terraform/modules/system/clouds/iam-core?ref=master&depth=1"
  # on that:
  # source = "$path_to_root/terraform/modules/system/clouds/iam-core"

}

#root_path=$1

files=$(grep -rwl . -e git::ssh://git@bb.yandexcloud.net/cloud/bootstrap-templates.git)
for file in $files; do
  process_file $file
done
