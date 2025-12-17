FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir openllm

RUN useradd -m -u 1000 openllm && \
    mkdir -p /data && \
    chown -R openllm:openllm /data

ENV HF_HOME=/data/huggingface
ENV OPENLLM_HOME=/data/openllm

USER openllm
WORKDIR /data

EXPOSE 3000

ENTRYPOINT ["openllm", "serve"]
