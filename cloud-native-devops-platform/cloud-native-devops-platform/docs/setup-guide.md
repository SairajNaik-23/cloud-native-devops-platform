# Local setup guide

## 1. Get the code

```bash
git clone <YOUR_REPOSITORY_URL>
cd cloud-native-devops-platform
```

## 2. Run tests

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r app/requirements.txt -r app/requirements-dev.txt
pytest -q app/tests
```

On Windows PowerShell, activate with `.venv\Scripts\Activate.ps1`.

## 3. Run the service

```bash
python app/app.py
```

Check `/` and `/health` on port 5000. Stop with Ctrl+C.

## 4. Build the image

```bash
docker build -f docker/Dockerfile -t cloud-native-devops-platform:local .
docker run --rm -p 5000:5000 cloud-native-devops-platform:local
```

## 5. Validate Kubernetes manifests

Install `kubectl` and a local cluster such as kind. Follow the local cluster steps in the main README. The default image must be available to the cluster before the pod can start.
