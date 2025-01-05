curl http://localhost:16301/status




channels:
  - name: metrics_push
    channel:
      pipe: []
      output:
        plugin: yc_metrics
        config:
          folder_id: yc.iam.idp-folder
          url: https://monitoring.private-api.cloud.yandex.net/monitoring/v2/data/write
          iam:
            jwt:
              file: /etc/sa-metrics-pusher-key.json
