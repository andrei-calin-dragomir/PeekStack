from flask import Flask, request, send_file
import requests
import io
import zipfile
import json

app = Flask(__name__)

# List of Prometheus endpoints your aggregator queries
PROMETHEUS_ENDPOINTS = [
    "http://prometheus-a:9090",
    "http://prometheus-b:9090"
]

@app.route("/fetch_metrics", methods=["GET"])
def fetch_metrics():
    """
    Example usage:
      GET /fetch_metrics?query=node_cpu_seconds_total&start=1672531200&end=1672534800&step=15
    """

    query = request.args.get("query", "up")
    start = request.args.get("start", None)
    end = request.args.get("end", None)
    step = request.args.get("step", "30")

    # Basic validation
    if not start or not end:
        return {"error": "Missing 'start' or 'end' query parameters."}, 400

    try:
        start_ts = float(start)
        end_ts = float(end)
    except ValueError:
        return {"error": "Invalid start or end time."}, 400

    # Prepare an in-memory ZIP buffer
    zip_buffer = io.BytesIO()
    with zipfile.ZipFile(zip_buffer, "w", zipfile.ZIP_DEFLATED) as zf:
        
        for idx, prom_url in enumerate(PROMETHEUS_ENDPOINTS):
            range_query_url = f"{prom_url}/api/v1/query_range"
            params = {
                "query": query,
                "start": start_ts,
                "end": end_ts,
                "step": step
            }

            try:
                resp = requests.get(range_query_url, params=params, timeout=10)
                resp.raise_for_status()
            except requests.exceptions.RequestException as e:
                # If the Prometheus endpoint is unavailable or times out, handle gracefully
                error_text = f"Error fetching from {prom_url}: {str(e)}"
                # Optionally you can skip, or write an error message into the ZIP
                # We'll just continue to the next endpoint for demonstration
                continue

            data_json = resp.json()

            # Add custom label to each result
            # Prometheus format:
            # {
            #   "status": "success",
            #   "data": {
            #     "resultType": "matrix",
            #     "result": [
            #       {
            #         "metric": {
            #           "__name__": "some_metric",
            #           ...
            #         },
            #         "values": [ [timestamp, value], ... ]
            #       },
            #       ...
            #     ]
            #   }
            # }
            if data_json.get("status") == "success":
                for series in data_json["data"]["result"]:
                    # Insert or overwrite "endpoint" label
                    series["metric"]["endpoint"] = prom_url

            # Write the modified JSON to the ZIP
            filename = f"prom_{idx}.json"
            zf.writestr(filename, json.dumps(data_json, indent=2))

    zip_buffer.seek(0)
    return send_file(
        zip_buffer,
        as_attachment=True,
        download_name="metrics.zip",
        mimetype="application/zip"
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
