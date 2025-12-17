FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir openllm

ENV HF_HOME=/data/huggingface
ENV OPENLLM_HOME=/data/openllm

RUN useradd -m -u 1000 openllm
USER openllm

EXPOSE 3000

ENTRYPOINT ["openllm", "start"]
