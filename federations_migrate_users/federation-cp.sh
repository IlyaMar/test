#!/bin/bash
#set -x
set -e

SRC_FEDERATION_ID=$1;
DST_FEDERATION_ID=$2;
PROFILE=${3:-default}


if [[ -z "${DST_FEDERATION_ID}" ]]; then
  echo "Usage: $0 <SRC_FEDERATION_ID> <DST_FEDERATION_ID> [profile=default]"
  exit
fi

function list-users() {
  federation_id=$1

  yc --profile=${PROFILE} --format json iam federation --id ${federation_id} list-user-accounts |
    jq -rc ".[] | {name_id: .saml_user_account.name_id, id: .id}"
}

function add-user() {
  federation_id=$1
  name_id=$2

  yc --profile=${PROFILE} --format json \
    iam federation --id ${federation_id} add-user-accounts --name-ids=${name_id} |
    jq -rc .
}


USERS=$(list-users ${SRC_FEDERATION_ID})

for user in $USERS
do
  name_id=$(jq -rc .name_id <<< ${user})
  name_id=$(sed -e s/@instamart.ru/@sbermarket.ru/g <<< ${name_id})
  new_user=$(add-user ${DST_FEDERATION_ID} ${name_id})
  echo "$new_user"
done
