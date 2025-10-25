echo -e 'aaa\nbbb\ncccc' | xargs -L1 echo

kubectl -n iam get pods '-lapp.kubernetes.io/name=iam-oslogin-service' -o name | xargs -I '{}' echo "pod {}"

echo -e 'ecv070ijjj837r4rtva0\necv0759l3jbnnum6kukh\necv0ephbqv2nugqr6u3l' |
  xargs -I@ echo ycp --profile ${PROFILE?} maintenance reaper task-processor task change-pool --pool green --commit true StopContainerResourcesOpJob:@