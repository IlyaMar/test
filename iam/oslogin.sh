ycp --profile preprod-fed iam compute os-login get -r - <<< '{"cloud_id": "yc.bastion", "subject_id": "yc.bastion.service-account"}'


cd $A/cloud/iam/scripts/
INSTANCE_ID=b4e4r13606801gcjba5o
LOGIN="ilya-martynov"
PROFILE="kz"
./duty/run_oslogin_diagnostics.sh "${LOGIN}" "${INSTANCE_ID}" "${PROFILE}"

