https://docs.aws.amazon.com/rolesanywhere/latest/userguide/trust-model.html


wget https://rolesanywhere.amazonaws.com/releases/1.1.1/X86_64/Linux/aws_signing_helper -O ${HOME}/aws_signing_helper
chmod +x ${HOME}/aws_signing_helper

echo 're-assign creds to unified k8s'
cat >>"${HOME}/.aws/credentials" <<EOF
[dc-workload-identity-preprod]
 credential_process = ${HOME}/aws_signing_helper credential-process
    --certificate /home/ilya-martynov/IdeaProjects/test/cert/iam_ci_sa.crt
    --private-key /home/ilya-martynov/IdeaProjects/test/cert/iam_ci_sa.key
    --trust-anchor-arn arn:aws:rolesanywhere:eu-central-1:821159050485:trust-anchor/10ca07cc-2ffe-49e5-9839-ad936653cbd6
    --profile-arn arn:aws:rolesanywhere:eu-central-1:821159050485:profile/13227acb-a405-4ef9-b278-5cceb73b6b35
    --role-arn arn:aws:iam::821159050485:role/iam-deployer
EOF


~/aws_signing_helper credential-process --certificate iam_ci_sa.crt --private-key iam_ci_sa.key \
--trust-anchor-arn arn:aws:rolesanywhere:eu-central-1:821159050485:trust-anchor/10ca07cc-2ffe-49e5-9839-ad936653cbd6 \
--profile-arn arn:aws:rolesanywhere:eu-central-1:821159050485:profile/13227acb-a405-4ef9-b278-5cceb73b6b35 \
--role-arn arn:aws:iam::821159050485:role/iam-deployer