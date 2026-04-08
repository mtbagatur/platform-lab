from flask import Flask
import socket
import os

app = Flask(__name__)

@app.route("/")
def home():
    return {
        "message": "Hello from VS Code + SSH + Docker + Terraform + Kubernetes + Azure",
        "hostname": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "dev"),
        "version": os.getenv("APP_VERSION", "2.0.0"),
        "config_message": os.getenv("APP_MESSAGE", "no-config"),
        "secret": os.getenv("SECRET_KEY", "no-secret"),
    }

@app.route("/health")
def health():
    return {"status": "ok"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)