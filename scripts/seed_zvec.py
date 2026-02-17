from __future__ import annotations

import hashlib
import re
from pathlib import Path

from idea_service.domain.ports import VectorDocument
from idea_service.infrastructure.zvec_store import ZvecVectorStore


def _hash_to_vector(text: str, dim: int) -> list[float]:
    digest = hashlib.sha256(text.encode("utf-8")).digest()
    values = []
    for i in range(dim):
        values.append(digest[i] / 255.0)
    return values


def _chunk_text(text: str, chunk_size: int) -> list[str]:
    chunks = []
    start = 0
    while start < len(text):
        chunks.append(text[start : start + chunk_size])
        start += chunk_size
    return chunks


def _safe_doc_id(raw_id: str) -> str:
    cleaned = re.sub(r"[^A-Za-z0-9_-]+", "_", raw_id)
    return cleaned.strip("_") or "doc"


def main() -> None:
    kb_path = Path("knowledge_base")
    store = ZvecVectorStore(path="./local_zvec_kb", collection_name="kb_collection", vector_dim=8)

    documents = []
    for file_path in sorted(kb_path.glob("*.md")):
        text = file_path.read_text(encoding="utf-8").strip()
        for idx, chunk in enumerate(_chunk_text(text, chunk_size=200)):
            doc_id = _safe_doc_id(f"{file_path.stem}_chunk_{idx}")
            vector = _hash_to_vector(chunk, dim=8)
            documents.append(VectorDocument(doc_id=doc_id, vector=vector))

    store.upsert_documents(documents)
    print(f"Seeded Zvec with {len(documents)} chunks.")


if __name__ == "__main__":
    main()
