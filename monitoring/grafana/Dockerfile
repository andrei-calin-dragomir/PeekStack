FROM grafana/grafana

# Add in the configuration file from the local directory.
ADD datasource.yml /etc/grafana/provisioning/datasources/datasource.yml
ADD dashboard.yml /etc/grafana/provisioning/dashboards/dashboard.yml

COPY ./hpc_monitoring.json /etc/grafana/provisioning/dashboards/