from __future__ import annotations

from dataclasses import dataclass
from typing import Iterable, List, Optional, Protocol

from idea_service.domain.entities import DriftMetric, Feedback, Idea, Report


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


class LLMClient(Protocol):
    def generate_report(self, prompt: str) -> str:
        ...


class IdeaRepository(Protocol):
    def save_idea(self, idea: Idea) -> None:
        ...

    def get_idea(self, idea_id: str) -> Optional[Idea]:
        ...

    def save_report(self, report: Report) -> None:
        ...

    def get_report(self, idea_id: str) -> Optional[Report]:
        ...

    def save_feedback(self, feedback: Feedback) -> None:
        ...


class MetricsRepository(Protocol):
    def save_metric(self, metric: DriftMetric) -> None:
        ...

    def get_metrics(self, metric_name: str) -> List[DriftMetric]:
        ...
