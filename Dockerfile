# ==========================================
# Stage 1: Build & Dependency Resolution
# ==========================================
FROM python:3.11-slim as builder

WORKDIR /build

# Prevent Python from writing bytecode and enable unbuffered logging
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY src/requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ==========================================
# Stage 2: Minimal Non-Root Production Image
# ==========================================
FROM python:3.11-slim as production

# Create a non-privileged system user and group (UID 10001) for security
RUN groupadd -g 10001 appgroup && \
    useradd -u 10001 -g appgroup -s /bin/false -m appuser

WORKDIR /app

# Copy installed dependencies from builder stage
COPY --from=builder /install /usr/local

# Copy application code with correct ownership
COPY --chown=appuser:appgroup src/ ./src/

# Switch to non-root user
USER 10001

# Expose non-privileged port
EXPOSE 8080

# Health probe check for Docker standalone / local environments
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD ["python", "-c", "import urllib.request; urllib.request.urlopen('http://localhost:8080/healthz')"]

# Run Uvicorn server
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8080", "--workers", "2"]
