cd ~/arcadia-dashboard/cloud/java/dashboard
./docker-build.sh
export GRAFANA_OAUTH_TOKEN=y1_AQAD-qJSM...
USE_TMP=true ./spec-single.sh upload main iam/sli.yaml