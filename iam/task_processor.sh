ycp --profile prod maintenance resource-manager task-processor task search --limit 10000 --prefix ApplyBlockPermissionsJob | grep -P '^>' | wc -l
ycp --profile=testing maintenance organization-manager task-processor task search --task-ids=DeleteOrganizationJob#e4l1npsc56pvkr57u1f7

ycp --profile doublecloud-aws-prod --impersonate-service-account-id yc.iam.service-account maintenance resource-manager task-processor task search --limit 10000 --prefix ApplyBlockPermissionsJob


POST /app/rest/buildQueue
{
  "branchName": "myBranch",
  "personal": true,
  "buildType": {
    "id": "IAM_Release_Tools_IamDoubleCloudRelease"
  },
  "comment": {
    "text": "DC release"
  },
  "properties": {
    "property": [{
      "name": "saltCommitId",
      "value": "myValue"
    },
    {
      "name": "servicePath",
      "value": "token-service",
    },
    {
      "name": "stand",
      "value": "preprod",
    }
    ]
  }
}

