# openllm-oneshot

Helm chart for deploying LLMs on Kubernetes using [OpenLLM](https://github.com/bentoml/OpenLLM).

## Install

```bash
helm repo add openllm-oneshot https://sokryptk.github.io/helm-openllm-oneshot
helm repo update
helm install my-llm openllm-oneshot/openllm-oneshot \
  --set model.id=HuggingFaceTB/SmolLM-135M-Instruct
```

## Configuration

### Model

```yaml
model:
  id: HuggingFaceTB/SmolLM-135M-Instruct
  backend: pt  # pt | vllm
```

### GPU

```bash
helm install my-llm openllm-oneshot/openllm-oneshot \
  --set model.id=mistralai/Mistral-7B-Instruct-v0.2 \
  --set gpu.enabled=true
```

### HuggingFace Token

```bash
helm install my-llm openllm-oneshot/openllm-oneshot \
  --set model.id=meta-llama/Llama-2-7b-chat-hf \
  --set huggingface.token=$HF_TOKEN
```

### Persistence

Cache models across restarts:

```bash
helm install my-llm openllm-oneshot/openllm-oneshot \
  --set persistence.enabled=true \
  --set persistence.size=100Gi
```

### Scaling

```yaml
autoscaling:
  enabled: true
  minReplicas: 1
  maxReplicas: 5
```

## Base Image

Uses `ghcr.io/sokryptk/openllm-base` with OpenLLM pre-installed. Models download on first startup and are cached in the PVC.

## License

MIT
