# DevSecOps CI/CD Pipeline & Containerized Web Service

[![DevSecOps Pipeline](https://github.com/Yukihara64/devsecops-cicd-pipeline-showcase/actions/workflows/devsecops-pipeline.yml/badge.svg)](https://github.com/Yukihara64/devsecops-cicd-pipeline-showcase/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Overview
This repository demonstrates a secure CI/CD workflow for a Python FastAPI microservice. It incorporates automated code linting, security vulnerability scanning, multi-architecture container builds, and Software Bill of Materials (SBOM) generation using GitHub Actions.

## Pipeline Architecture
The GitHub Actions workflow runs the following automated steps on every push and pull request:
1. **Code Analysis & Linting**: Validates Python syntax and code formatting using lake8 and lack.
2. **Container Build**: Compiles Docker images supporting both md64 and rm64 architectures.
3. **Vulnerability Scanning**: Analyzes container layers and application dependencies for known security flaws using Trivy.
4. **SBOM Generation**: Generates a complete Software Bill of Materials in SPDX JSON format using Syft to track third-party dependencies.
5. **Registry Publish**: Pushes the validated image to GitHub Container Registry (GHCR).

## Project Structure
* pp/ - Python FastAPI REST API endpoints and application logic.
* Dockerfile - Multi-stage, optimized Dockerfile using a non-root container user for improved security.
* 
equirements.txt - Project package dependencies.
* .github/workflows/devsecops-pipeline.yml - Automated CI/CD pipeline definition.

## Running Locally
To run the API service locally using Docker:
`ash
# Build the container image
docker build -t fastapi-service:latest .

# Run the container on port 8000
docker run -p 8000:8000 fastapi-service:latest

# Access the interactive API documentation at http://localhost:8000/docs
`
