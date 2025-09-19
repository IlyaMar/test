cd ~/arcadia-dashboard/cloud/java/dashboard
./docker-build.sh
export GRAFANA_OAUTH_TOKEN=$(cat ~/.grafana_oauth)
USE_TMP=true ./spec-single.sh upload main iam/sli.yaml