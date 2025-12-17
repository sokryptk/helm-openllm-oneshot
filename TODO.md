# Nexus Helm Chart - TODO

Helm chart for deploying LLMs using BentoML/OpenLLM on Kubernetes.

## Completed
- [x] Created directory structure (`~/nexus/templates/`)
- [x] Created `Chart.yaml` (maintainer: sokryptk)

## Remaining Tasks

### 1. Create `values.yaml`
Configurable values including:
- Model selection (e.g., `mistralai/Mistral-7B-Instruct-v0.2`, `meta-llama/Llama-2-7b-chat-hf`)
- Model backend (vllm, pt, etc.)
- Resource limits (GPU, memory, CPU)
- Replica count
- Service type (LoadBalancer)
- HuggingFace token secret reference
- Environment variables

### 2. Create `templates/deployment.yaml`
- Pod spec with OpenLLM container
- GPU resource requests
- Volume mounts for model cache
- Environment variables from configmap/secrets
- Health checks (liveness/readiness probes)

### 3. Create `templates/service.yaml`
- LoadBalancer type service
- Expose port 3000 (OpenLLM default)
- External traffic policy

### 4. Create `templates/configmap.yaml`
- Model configuration
- Runtime settings

### 5. Create `templates/_helpers.tpl`
- Common labels
- Name helpers
- Selector labels

### 6. Create `templates/secret.yaml` (optional)
- HuggingFace token for gated models

### 7. Create `templates/pvc.yaml` (optional)
- Persistent volume for model cache

### 8. Create `templates/NOTES.txt`
- Post-install instructions
- How to get LoadBalancer IP
- API usage examples

## Key Design Decisions
- Use `ghcr.io/bentoml/openllm` as base image
- Models configurable via `values.yaml`
- LoadBalancer exposes cluster access
- GPU support via nvidia device plugin
