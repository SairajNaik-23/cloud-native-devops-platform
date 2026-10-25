import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from app import app

def test_home_returns_service_details():
    response = app.test_client().get("/")
    assert response.status_code == 200
    data = response.get_json()
    assert data["service"] == "cloud-native-devops-platform"

def test_health_endpoint():
    response = app.test_client().get("/health")
    assert response.status_code == 200
    assert response.get_json() == {"status": "ok"}
