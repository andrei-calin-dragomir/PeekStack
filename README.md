# greenlab-docker-swarm
![Swarm Monitoring Deployment Status](https://img.shields.io/badge/Monitoring-deployable-brightgreen)
![Swarm Autoscaler Deployment Status](https://img.shields.io/badge/Autoscaler-deployable-brightgreen)
![Swarm Experiment Runner Interface Deployment Status](https://img.shields.io/badge/ExperimentRunner-workinprogress-yellow)
![Swarm Migrator Deployment Status](https://img.shields.io/badge/Migrator-theoretical-lightgrey)

## Cluster Configuration (GreenLab)
![Cluster Configuration](GreenLab.png)

## About
This repository contains the toolkit for gathering, processing and exporting machine metrics with a focus on power consumption.
It also provides services that provide container orchestrating techniques with a focus on energy efficiency optimizations.

Each module contains its own `README.md` where you can find more information about how the modules are implemented as well as usage instructions.

### General
- Containerization Platform: [Docker](https://docs.docker.com/engine/swarm/)

### Available metrics
- [CAdvisor](https://github.com/google/cadvisor/blob/master/docs/storage/prometheus.md): Analyzes resource usage and performance characteristics of running containers. 
- [Scaphandre]()
- [Node-Exporter]()


