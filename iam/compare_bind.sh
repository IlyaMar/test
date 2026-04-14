
ycp --profile internal-dev iam backoffice  access-binding list-by-subject --subject-id yc.iam.service-account > ~/bind_int_dev
ycp --profile internal-prestable iam backoffice  access-binding list-by-subject --subject-id yc.iam.service-account > ~/bind_int_prestable
ycp --profile prod iam backoffice  access-binding list-by-subject --subject-id yc.iam.service-account > ~/bind_prod

cat ~/bind_int_prestable | yq '. | sort_by(.role_id)' > int_prestable2
cat ~/bind_int_dev | yq '. | sort_by(.role_id)' > int_dev2

diff <(cat bind_int_dev2) <(cat bind_int_prestable2)
