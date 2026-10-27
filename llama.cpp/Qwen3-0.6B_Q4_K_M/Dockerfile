# syntax=docker/dockerfile:1
# Official llama.cpp server image; supports CPU and GPU variants through the image tag.
FROM ghcr.io/ggml-org/llama.cpp:server

ARG MODEL_URL=https://huggingface.co/unsloth/Qwen3-0.6B-GGUF/resolve/main/Qwen3-0.6B-Q4_K_M.gguf?download=true
ENV MODEL_PATH=/models/Qwen3-0.6B-Q4_K_M.gguf

USER root
RUN mkdir -p /models
# Download the exact Q4_K_M artifact during image build so the resulting image is self-contained.
ADD ${MODEL_URL} ${MODEL_PATH}

EXPOSE 8080

ENTRYPOINT ["/app/llama-server"]
CMD ["--model", "/models/Qwen3-0.6B-Q4_K_M.gguf", "--host", "0.0.0.0", "--port", "8080", "--ctx-size", "4096", "--n-predict", "512", "--threads", "4", "--parallel", "2", "--reasoning-format", "none"]
