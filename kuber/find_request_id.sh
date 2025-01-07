#!/bin/bash -eux

request_id=$1
app=${2:-access-service}

day0=$(TZ=UTC date                '+%Y-%m-%d')
day1=$(TZ=UTC date -d "1 day ago" '+%Y-%m-%d')

pods=$(kubectl get pod -l yc.iam.app=$app --output=jsonpath={.items..metadata.name})
for pod in $pods; do
  echo "search in $pod"
  kubectl exec $pod -c $app -- grep $request_id /var/log/yc/$app/access.log || true
  #kubectl exec $pod -c $app -- bash -c "zgrep $request_id /var/log/yc/$app/access-${day0}*.log.gz" || true
  #kubectl exec $pod -c $app -- bash -c "zgrep $request_id /var/log/yc/$app/access-${day1}*.log.gz" || true
done



