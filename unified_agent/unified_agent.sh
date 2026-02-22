cat curl http://localhost:16301/status > status.yml

cd ~/arcadia/logbroker/unified_agent/tools/status_graph
ya make
./status_graph --input ~/status.yml --output ~/status




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


yandex-unified-agent                25.07.40



Feb 12 16:05:27 iam-rm-vla1.svc.cloud-preprod.yandex.net systemd[1]: Failed to start Yandex Unified Agent service.
Feb 12 16:05:29 iam-rm-vla1.svc.cloud-preprod.yandex.net systemd[1]: unified-agent.service: Scheduled restart job, restart counter is at 99.
Feb 12 16:05:29 iam-rm-vla1.svc.cloud-preprod.yandex.net systemd[1]: Stopped Yandex Unified Agent service.
Feb 12 16:05:29 iam-rm-vla1.svc.cloud-preprod.yandex.net systemd[1]: Starting Yandex Unified Agent service...
Feb 12 16:05:29 iam-rm-vla1.svc.cloud-preprod.yandex.net unified_agent[3914070]: /etc/yandex/unified_agent/conf.d/rm-control-plane_metrics.yml, line 14, column 19: unknown filter plugin [change_metric_type]
Feb 12 16:05:29 iam-rm-vla1.svc.cloud-preprod.yandex.net systemd[1]: unified-agent.service: Control process exited, code=exited, status=1/FAILURE
Feb 12 16:05:29 iam-rm-vla1.svc.cloud-preprod.yandex.net systemd[1]: unified-agent.service: Failed with result 'exit-code'.
Feb 12 16:05:29 iam-rm-vla1.svc.cloud-preprod.yandex.net systemd[1]: Failed to start Yandex Unified Agent service.
(PRE-PROD) root@iam-rm-vla1:/etc/yandex/unified_agent/conf.d# apt-get install --allow-downgrades yandex-unified-agent=25.07.40^C
(PRE-PROD) root@iam-rm-vla1:/etc/yandex/unified_agent/conf.d# dpkg -l | grep unified
ii  yandex-unified-agent                26.01.10                                         amd64        Yandex Unified Agent
