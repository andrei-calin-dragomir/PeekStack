#!/bin/bash

set -e

# Load user config
source config.env

# Detect external IP
SERVER_IP=$(hostname -I | awk '{print $1}')
echo "Detected server IP: $SERVER_IP"

HOST_NAME=$(grep -E '^HOST_NAME=' config.env | cut -d= -f2)

if [ -z "$HOST_NAME" ]; then
  HOST_NAME=$(hostname)
fi

AUTH_USERNAME=$(grep -E '^AUTH_USERNAME=' config.env | cut -d= -f2)

if [ -z "$AUTH_USERNAME" ]; then
  AUTH_USERNAME="admin"
fi

AUTH_PASSWORD=$(grep -E '^AUTH_PASSWORD=' config.env | cut -d= -f2)

if [ -z "$AUTH_PASSWORD" ]; then
  echo "No AUTH_PASSWORD specified, defaulting to 'password'"
  AUTH_PASSWORD="password"
fi


echo "Creating nginx certificates for HTTPS access..."
# Create folder structure
mkdir -p nginx/certs prometheus

# Create OpenSSL config for IP-based SAN
cat > openssl-ip.cnf <<EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
x509_extensions = v3_req

[dn]
CN = $SERVER_IP

[v3_req]
subjectAltName = @alt_names

[alt_names]
IP.1 = $SERVER_IP
EOF

# Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx/certs/key.pem \
  -out nginx/certs/cert.pem \
  -config openssl-ip.cnf

echo "Setting up credentials for nginx access..."
# Create basic auth file
htpasswd -cb nginx/.htpasswd "$AUTH_USERNAME" "$AUTH_PASSWORD"

# Clean up
rm -f openssl-ip.cnf

echo "✅ Certificate and credentials created for IP: $SERVER_IP"

echo "Creating Prometheus configuration..."
# Write config to file
cat > prometheus/prometheus.yml <<EOF
global:
  scrape_interval: 2s # If set lower than 2s, scaphandre power metrics will fail to scrape
  scrape_timeout: 2s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['prometheus:9090']
        labels:
          host: $HOST_NAME

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']
        labels:
          host: $HOST_NAME

  - job_name: 'scaphandre'
    static_configs:
      - targets: ['scaphandre:8080']
        labels:
          host: $HOST_NAME

  - job_name: 'cadvisor'
    static_configs:
      - targets: ['cadvisor:8081']
        labels:
          host: $HOST_NAME
EOF
echo "✅ prometheus.yml generated with host: $HOST_NAME"

echo "You can now run: docker compose up -d"
