from flask import Flask
import socket

app = Flask(__name__)

@app.get("/")
def hello():
    return f"Hi from GKE Autopilot! pod={socket.gethostname()}\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
