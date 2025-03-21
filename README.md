# Cluster Monitoring

This repository contains the toolkit for gathering, processing and exporting machine metrics with a focus on power consumption, deployed using [Docker](https://docs.docker.com/engine/)

### Available metrics
- [CAdvisor](https://github.com/google/cadvisor/blob/master/docs/storage/prometheus.md): Analyzes resource usage and performance characteristics of running container;
- [Scaphandre](https://hubblo-org.github.io/scaphandre-documentation/references/metrics.html): Measuring power/energy consumed on bare metal hosts;
- [Node-Exporter](https://github.com/prometheus/node_exporter?tab=readme-ov-file#collectors): Exporter for machine level metrics.

### Setup
In order to setup the `collector` stack you need to take the following steps:
1. Create a `config.env` file in the `collector` directory containing:

| Variable Name   | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| `AUTH_USERNAME` | Username for basic HTTPS authentication used to access Prometheus/NGINX. Defaults to 'admin'   |
| `AUTH_PASSWORD` | Password for the above user. Used to generate the `.htpasswd` file. Defaults to 'password'      |
| `HOST_NAME`     | Custom label for the host machine in Prometheus scrape configs. Defaults to system hostname. |

2. Run the `setup.sh` file present in its directory which sets up the credentials based connection to the stack as well as configuring HTTPS connectivity to the Prometheus endpoint.

3. If the script runs successfully, you can now deploy the stack using `docker compose up -d`

4. You can now access the Prometheus database using the credentials from your `config.env` file on the `https://<machine_IP>:9090/`.

**Note:** When accessing the database, your browser will warn you to not access due to the certificates of the endpoint being self-signed.

### Known Limitations
1. Scaphandre can only be polled for energy based metrics once every 2 seconds, with the latest tested version (v1.0.2)
2. 