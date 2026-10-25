PYTHON ?= python3
PIP ?= pip
IMAGE ?= cloud-native-devops-platform:local

.PHONY: install test run docker-build docker-run terraform-check

install:
	$(PIP) install -r app/requirements.txt -r app/requirements-dev.txt

test:
	$(PYTHON) -m pytest -q app/tests

run:
	$(PYTHON) app/app.py

docker-build:
	docker build -f docker/Dockerfile -t $(IMAGE) .

docker-run:
	docker run --rm -p 5000:5000 $(IMAGE)

terraform-check:
	cd terraform && terraform fmt -check -recursive && terraform init -backend=false && terraform validate
