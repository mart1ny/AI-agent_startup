from __future__ import annotations

from dataclasses import dataclass
from typing import Iterable, List, Optional, Protocol


@dataclass(frozen=True)
class VectorDocument:
    doc_id: str
    vector: List[float]
    metadata: Optional[dict] = None


@dataclass(frozen=True)
class VectorSearchResult:
    doc_id: str
    score: float
    metadata: Optional[dict] = None


class VectorStore(Protocol):
    def upsert_documents(self, documents: Iterable[VectorDocument]) -> None:
        ...

    def query_similar(self, query_vector: List[float], top_k: int) -> List[VectorSearchResult]:
        ...

    def delete_by_ids(self, doc_ids: Iterable[str]) -> None:
        ...

    def get_by_id(self, doc_id: str) -> Optional[VectorDocument]:
        ...
