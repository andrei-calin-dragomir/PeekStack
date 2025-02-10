# greenlab-monitoring-stack (Docker Swarm)

## About
This stack provides metrics gathered by [CAdvisor](https://github.com/google/cadvisor), [Scaphandre](https://hubblo-org.github.io/scaphandre-documentation/references/metrics.html) and [Node-Exporter](https://github.com/prometheus/node_exporter) which can be visualized through Grafana.

The DB we use is InfluxDB v2 which uses the [Flux](https://docs.influxdata.com/influxdb/v2/tags/flux/) querying language.

## Avaliable Dashboards

_Grafana Credentials: admin admin_

- Power & CPU Utilization
  - This dashboard provides data regarding power and CPU Utilization in both a general overview (per Machine) as well as fine-grained (per active Process).
  - The querying language used is FluxV2
  - The data is extracted from Scaphandre.

## Port Configurations
| Service         | Exposed Port |
| --------        | -----|
| InfluxDB        | 18086 |
| Grafana         | 13000 |
| Telegraf        | 18125 |
| Scaphandre      | 18080 |
| Node-Exporter   | 19100 |
| CAdvisor        | 18081 |
