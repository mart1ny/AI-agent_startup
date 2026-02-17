from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime
from typing import Optional


@dataclass(frozen=True)
class Idea:
    idea_id: str
    idea_text: str
    industry: Optional[str] = None
    region: Optional[str] = None
    stage: Optional[str] = None
    created_at: Optional[datetime] = None


@dataclass(frozen=True)
class Report:
    idea_id: str
    report_json: dict
    model_version: str
    prompt_version: str
    created_at: Optional[datetime] = None


@dataclass(frozen=True)
class Feedback:
    idea_id: str
    rating: int
    useful: bool
    comment: Optional[str] = None
    success: Optional[bool] = None
    created_at: Optional[datetime] = None


@dataclass(frozen=True)
class DriftMetric:
    metric_date: datetime
    metric_name: str
    metric_value: float
    model_version: str
    prompt_version: str
