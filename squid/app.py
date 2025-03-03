import subprocess
from flask import Flask, jsonify, request

app = Flask(__name__)

# Inline HTML template for a simple web UI
HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>Squid Restart UI</title>
    <style>
        /* A small circle for indicating status */
        #status-circle {
            display: inline-block;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            margin-left: 8px;
        }
        /* Fade the restart button while disabled */
        #restart-button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <h1>Squid Proxy Restart UI</h1>
    <div>
        <span>Status: 
            <span id="status-circle" style="background-color: grey;"></span>
        </span>
        <button id="restart-button" onclick="restartSquid()">Restart Squid</button>
    </div>

    <script>
        // Poll the Squid status every few seconds to update the UI.
        setInterval(getStatus, 5000);
        window.onload = getStatus;

        function getStatus() {
            fetch('/status')
                .then(response => response.json())
                .then(data => {
                    const circle = document.getElementById('status-circle');
                    const button = document.getElementById('restart-button');
                    
                    if (data.status === 'active') {
                        // Green circle, enable button
                        circle.style.backgroundColor = 'green';
                        button.disabled = false;
                    } else {
                        // Red circle, disable button
                        circle.style.backgroundColor = 'red';
                        button.disabled = true;
                    }
                })
                .catch(err => {
                    console.log("Error fetching status:", err);
                });
        }

        function restartSquid() {
            // Immediately set circle to red and disable the button
            const circle = document.getElementById('status-circle');
            const button = document.getElementById('restart-button');
            circle.style.backgroundColor = 'red';
            button.disabled = true;

            // Send a POST request to trigger the restart
            fetch('/restart', { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    console.log("Restart initiated:", data);

                    // After initiating the restart, poll every second
                    // until we get 'active' again
                    const pollInterval = setInterval(() => {
                        fetch('/status')
                            .then(res => res.json())
                            .then(statusData => {
                                if (statusData.status === 'active') {
                                    circle.style.backgroundColor = 'green';
                                    button.disabled = false;
                                    clearInterval(pollInterval);
                                }
                            })
                            .catch(err => {
                                console.log("Error polling status:", err);
                            });
                    }, 1000);
                })
                .catch(err => {
                    console.log("Error restarting Squid:", err);
                });
        }
    </script>
</body>
</html>
"""

def is_squid_active():
    """
    Checks if the Squid service is currently active using systemctl is-active.
    Returns the status string (e.g., 'active', 'inactive', 'failed', etc.).
    """
    try:
        output = subprocess.check_output(
            ["systemctl", "is-active", "squid.service"],
            stderr=subprocess.STDOUT
        )
        return output.decode('utf-8').strip()
    except subprocess.CalledProcessError:
        return "inactive"

@app.route("/")
def index():
    """
    Serve the main HTML interface.
    """
    return HTML_TEMPLATE

@app.route("/status")
def get_squid_status():
    """
    Returns JSON with the current status of the Squid service.
    """
    status = is_squid_active()
    return jsonify({"status": status})

@app.route("/restart", methods=["POST"])
def restart_squid():
    """
    Triggers a systemctl restart for the Squid service. Returns a JSON response.
    """
    # Since this script will run as root, no sudo is needed:
    subprocess.Popen(["systemctl", "restart", "squid.service"])
    return jsonify({"message": "Restart initiated"})

if __name__ == "__main__":
    # Serve on port 80, available on all interfaces
    app.run(host="0.0.0.0", port=80)

