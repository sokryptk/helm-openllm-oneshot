# openllm-oneshot

Helm chart for deploying LLMs on Kubernetes using [BentoML/OpenLLM](https://github.com/bentoml/OpenLLM).

## Install

```bash
helm repo add openllm-oneshot https://sokryptk.github.io/helm-openllm-oneshot
helm repo update
helm install my-llm openllm-oneshot/openllm-oneshot
```

## Configuration

### Model

```yaml
model:
  source: huggingface  # huggingface | local | s3 | gcs
  id: mistralai/Mistral-7B-Instruct-v0.2
  backend: vllm  # vllm | pt
  quantization: null  # int8 | int4 | gptq | awq
```

### GPU

Disabled by default. Enable with:

```bash
helm install my-llm openllm-oneshot/openllm-oneshot --set gpu.enabled=true
```

### Scaling

```yaml
autoscaling:
  enabled: true
  minReplicas: 1
  maxReplicas: 5
  targetCPUUtilizationPercentage: 70
```

### HuggingFace Token

For gated models:

```bash
helm install my-llm openllm-oneshot/openllm-oneshot \
  --set model.id=meta-llama/Llama-2-7b-chat-hf \
  --set huggingface.token=$HF_TOKEN
```

Or use an existing secret:

```bash
kubectl create secret generic hf-token --from-literal=token=$HF_TOKEN
helm install my-llm openllm-oneshot/openllm-oneshot \
  --set huggingface.existingSecret=hf-token
```

### All Values

See [values.yaml](values.yaml) for all configuration options.

## License

MIT
