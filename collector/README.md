# 🛠️ Collector

This stack exposes aggregated machine metrics through a **Prometheus** database, secured behind an **NGINX gateway** with HTTPS and basic authentication.

---

## Setup Instructions

Follow these steps to configure and deploy the `collector` stack.

---

### 1. Create `config.env` (optional but recommended)

In the `collector` directory, create a `config.env` file with the following variables:

| Variable        | Description                                                                 |
|-----------------|-----------------------------------------------------------------------------|
| `AUTH_USERNAME` | Username for basic HTTPS authentication (used to access Prometheus through NGINX). Defaults to `admin`. |
| `AUTH_PASSWORD` | Password for the above user. Used to generate the `.htpasswd` file. Defaults to `admin`. |
| `HOST_NAME`     | Optional label for the host in Prometheus metrics. Defaults to the system hostname. |

---

### 2. Run the Setup Script

Run the `setup.sh` script from the `collector` directory:

```bash
./setup.sh
```

This script will:
- Generate self-signed HTTPS certificates
- Create the `.htpasswd` file for basic authentication
- Apply NGINX configuration with TLS and credentials

### 3. Deploy the Stack
Start the collector services using Docker Compose:

```bash
docker compose up -d
```

### 4. Access Prometheus

Once the stack is running, access the Prometheus web UI at:

`https://<your_machine_ip>:19090/`

Log in using the credentials defined in your `config.env` file.

**Note:** Your browser will likely display a warning because the certificate is self-signed. You can safely bypass it for local use.

