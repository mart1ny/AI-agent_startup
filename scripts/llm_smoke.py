from __future__ import annotations

import os

from idea_service.infrastructure.llama_cpp_client import LlamaCppClient


def main() -> None:
    model_path = os.environ.get(
        "LLAMA_MODEL_PATH",
        "models/qwen2.5-7b-instruct-q4_k_m-00001-of-00002.gguf",
    )
    client = LlamaCppClient(
        model_path=model_path,
        n_ctx=512,
        max_tokens=64,
        verbose=False,
    )
    prompt = (
        "Generate a short JSON with keys: viability_score, risk_score, confidence. "
        "Return only JSON."
    )
    result = client.generate_report(prompt)
    print(result)


if __name__ == "__main__":
    main()
