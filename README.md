# DevSecOps CI/CD Pipeline & Web Service

[![DevSecOps Pipeline](https://github.com/Yukihara64/devsecops-cicd-pipeline-showcase/actions/workflows/devsecops-pipeline.yml/badge.svg)](https://github.com/Yukihara64/devsecops-cicd-pipeline-showcase/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Overview
This repository demonstrates an automated CI/CD workflow for a Python FastAPI microservice. It incorporates code linting, container vulnerability scanning, multi-architecture builds, and Software Bill of Materials (SBOM) generation using GitHub Actions.

## Pipeline Workflow
The GitHub Actions pipeline runs automated checks on every push and pull request:

| Stage | Tools Used | Description |
| :--- | :--- | :--- |
| **1. Code Linting** | `flake8`, `black` | Validates Python code styling, formatting, and syntax consistency. |
| **2. Container Build** | Docker Buildx | Compiles multi-architecture container images supporting both `amd64` and `arm64`. |
| **3. Vulnerability Scan** | Trivy | Scans container OS layers and Python dependencies for known CVE vulnerabilities. |
| **4. SBOM Generation** | Syft | Generates a Software Bill of Materials in SPDX JSON format to document dependency supply chain. |
| **5. Registry Publish** | GHCR | Pushes the validated container image to GitHub Container Registry. |

## Repository Structure
```text
├── app/              # Python FastAPI REST API endpoints and application logic
├── Dockerfile        # Multi-stage container definition using a non-root user
├── requirements.txt  # Project package dependencies
└── .github/          # Automated CI/CD pipeline workflow definitions
```

## Local Development
To build and run the API service locally using Docker:

```bash
# Build the container image
docker build -t fastapi-service:latest .

# Run the container on port 8000
docker run -p 8000:8000 fastapi-service:latest

# Access interactive API docs at http://localhost:8000/docs
```
