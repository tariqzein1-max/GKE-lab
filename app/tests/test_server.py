from server import app

def test_root_ok():
    client = app.test_client()
    r = client.get("/")
    assert r.status_code == 200
    assert b"Hello" in r.data
