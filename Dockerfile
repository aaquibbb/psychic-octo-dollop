FROM python:3.11-slim

# Create non-root user — security best practice
RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

# Copy and install dependencies first (layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Switch to non-root user
USER appuser

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "app:app"]
