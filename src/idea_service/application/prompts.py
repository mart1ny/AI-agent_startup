from __future__ import annotations

from typing import Iterable


def build_analysis_prompt(idea_text: str, metadata: str, sources: Iterable[str]) -> str:
    sources_text = "\n".join(f"- {item}" for item in sources)
    return (
        "You are an analyst. Generate a strict JSON report for the startup idea.\n"
        "Return JSON only, no extra text, no markdown, no code fences.\n"
        "Schema:\n"
        "{\n"
        '  "viability_score": int (0-100),\n'
        '  "risk_score": int (0-100),\n'
        '  "confidence": float (0-1),\n'
        '  "market_summary": string,\n'
        '  "target_audience": string,\n'
        '  "business_model": string,\n'
        '  "key_assumptions": [string],\n'
        '  "risks": [{"category": string, "description": string, "severity": int (0-100)}],\n'
        '  "recommendations": [string],\n'
        '  "pivots": [string],\n'
        '  "sources": [{"chunk_id": string, "title": string, "score": float}]\n'
        "}\n"
        "Rules:\n"
        "- Output valid JSON.\n"
        "- Use only the provided sources.\n"
        "- If data is missing, use an empty string or empty list.\n"
        "\n"
        "Idea:\n"
        f"{idea_text}\n"
        "\n"
        "Metadata:\n"
        f"{metadata}\n"
        "\n"
        "Sources:\n"
        f"{sources_text}\n"
    )
