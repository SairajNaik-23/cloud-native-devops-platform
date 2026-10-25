FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=5000

WORKDIR /app
COPY app/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt     && groupadd --system appgroup     && useradd --system --gid appgroup --create-home appuser
COPY app/app.py ./app.py

USER appuser
EXPOSE 5000
CMD ["python", "app.py"]
