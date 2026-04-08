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
        "version": os.getenv("APP_VERSION", "unknown"),
        "config_message": os.getenv("APP_MESSAGE", "no-config")
    }

@app.route("/health")
def health():
    return {"status": "ok"}

@app.route("/info")
def info():
    secret_value = os.getenv("SECRET_KEY", "")
    return {
        "hostname": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "dev"),
        "version": os.getenv("APP_VERSION", "unknown"),
        "config_message": os.getenv("APP_MESSAGE", "no-config"),
        "secret_present": bool(secret_value),
        "secret_length": len(secret_value) if secret_value else 0
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)