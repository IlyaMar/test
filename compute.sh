FOLDER_ID=b1gu8md6fhhv44pq8ml7 IMG_ID=fd866inn9tr3b4qtalr8 SUBNET_NAME=ilya-martynov-net-ru-central1-a \
yc --impersonate-service-account-id yc.iam.service-account compute instance create \
  --profile prod-fed-user \
  --folder-id "$FOLDER_ID" \
  --name oslogin-test \
  --zone ru-central1-a \
  --cores 2 \
  --memory 2gb \
  --network-interface subnet-name="$SUBNET_NAME",nat-ip-version=ipv4 \
  --create-boot-disk image-id="$IMG_ID" \
  --ssh-key ~/.ssh/id_rsa.pub

yc --impersonate-service-account-id yc.iam.service-account compute instance create \
  --profile personal \
  --folder-id b1gms489id5l7g4p8ghq \
  --name oslogin-test \
  --zone ru-central1-a \
  --cores 2 \
  --memory 2gb \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --create-boot-disk image-id=fd866inn9tr3b4qtalr8 \
  --ssh-key ~/.ssh/id_rsa.pub
%%
