from __future__ import annotations

from typing import Optional

from llama_cpp import Llama

from idea_service.domain.ports import LLMClient


class LlamaCppClient(LLMClient):
    def __init__(
        self,
        model_path: str,
        n_ctx: int = 2048,
        n_threads: Optional[int] = None,
        temperature: float = 0.2,
        max_tokens: int = 512,
        verbose: bool = False,
    ) -> None:
        self._llm = Llama(
            model_path=model_path,
            n_ctx=n_ctx,
            n_threads=n_threads,
            verbose=verbose,
        )
        self._temperature = temperature
        self._max_tokens = max_tokens

    def generate_report(self, prompt: str) -> str:
        output = self._llm(
            prompt,
            max_tokens=self._max_tokens,
            temperature=self._temperature,
        )
        return output["choices"][0]["text"]
