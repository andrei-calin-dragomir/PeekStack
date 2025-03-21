# Cluster Monitoring

This repository contains the toolkit for gathering, processing and exporting machine metrics with a focus on power consumption.

### General
- Containerization Platform: [Docker](https://docs.docker.com/engine/)
```bash
Client: Docker Engine - Community
 Version:           27.3.1
 API version:       1.47

Server: Docker Engine - Community
 Engine:
  Version:          27.3.1
  API version:      1.47 (minimum version 1.24)
 containerd:
  Version:          1.7.22
```
### Available metrics
- [CAdvisor](https://github.com/google/cadvisor/blob/master/docs/storage/prometheus.md): Analyzes resource usage and performance characteristics of running container;
- [Scaphandre](https://hubblo-org.github.io/scaphandre-documentation/references/metrics.html): Measuring power/energy consumed on bare metal hosts;
- [Node-Exporter](https://github.com/prometheus/node_exporter?tab=readme-ov-file#collectors): Exporter for machine level metrics.


