import subprocess
from flask import Flask, jsonify

app = Flask(__name__)

HTML_TEMPLATE = """<!DOCTYPE html>
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
            vertical-align: middle;
        }
        /* Fade the restart button while disabled */
        #restart-button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        /* Spinner is hidden by default */
        #spinner {
            display: none;
            margin-left: 10px;
            vertical-align: middle;
            width: 24px;
            height: 24px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #888;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0%   { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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
        <div id="spinner"></div>
    </div>

    <script>
        // Poll the Squid status every 5 seconds to update the UI.
        setInterval(getStatus, 5000);
        window.onload = getStatus;

        function getStatus() {
            fetch('/status')
                .then(response => response.json())
                .then(data => {
                    const circle = document.getElementById('status-circle');
                    const button = document.getElementById('restart-button');
                    const spinner = document.getElementById('spinner');
                    
                    if (data.status === 'active') {
                        // Green circle, enable button, hide spinner
                        circle.style.backgroundColor = 'green';
                        button.disabled = false;
                        spinner.style.display = 'none';
                    } else {
                        // Red circle, disable button
                        circle.style.backgroundColor = 'red';
                        button.disabled = true;
                    }
                })
                .catch(err => {
                    console.log('Error fetching status:', err);
                });
        }

        function restartSquid() {
            // Immediately set circle to red, disable button, show spinner
            const circle = document.getElementById('status-circle');
            const button = document.getElementById('restart-button');
            const spinner = document.getElementById('spinner');

            circle.style.backgroundColor = 'red';
            button.disabled = true;
            spinner.style.display = 'inline-block';

            // Send a POST request to trigger the restart
            fetch('/restart', { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    console.log('Restart initiated:', data);

                    // Poll every second until we get 'active' again
                    const pollInterval = setInterval(() => {
                        fetch('/status')
                            .then(res => res.json())
                            .then(statusData => {
                                if (statusData.status === 'active') {
                                    circle.style.backgroundColor = 'green';
                                    button.disabled = false;
                                    spinner.style.display = 'none';
                                    clearInterval(pollInterval);
                                }
                            })
                            .catch(err => {
                                console.log('Error polling status:', err);
                            });
                    }, 1000);
                })
                .catch(err => {
                    console.log('Error restarting Squid:', err);
                });
        }
    </script>
</body>
</html>"""

def is_squid_active():
    """
    Return 'active' if Squid is running, otherwise 'inactive' or 'failed'.
    Uses the absolute path to systemctl so it can be found by systemd.
    """
    try:
        output = subprocess.check_output(
            ["/usr/bin/systemctl", "is-active", "squid.service"],
            stderr=subprocess.STDOUT
        )
        return output.decode("utf-8").strip()
    except subprocess.CalledProcessError:
        return "inactive"

@app.route("/")
def index():
    # Return the HTML page
    return HTML_TEMPLATE

@app.route("/status")
def get_squid_status():
    # Return JSON with the Squid service's current status
    status = is_squid_active()
    return jsonify({"status": status})

@app.route("/restart", methods=["POST"])
def restart_squid():
    # Spawn systemctl to restart squid without waiting for it to finish
    subprocess.Popen(["/usr/bin/systemctl", "restart", "squid.service"])
    return jsonify({"message": "Restart initiated"})

if __name__ == "__main__":
    # Listen on port 80 (requires root privileges or capability)
    app.run(host="0.0.0.0", port=80)

