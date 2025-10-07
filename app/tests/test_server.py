import os, sys
# add parent directory (the app/ folder) to module search path
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))

from server import app  # now this resolves to app/server.py

def test_root_ok():
    client = app.test_client()
    r = client.get("/")
    assert r.status_code == 200
    assert b"Hello" in r.data
