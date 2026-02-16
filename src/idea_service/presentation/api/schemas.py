from __future__ import annotations

from typing import List, Optional

from pydantic import BaseModel, Field


class RiskItem(BaseModel):
    category: str
    description: str
    severity: int = Field(ge=0, le=100)


class SourceItem(BaseModel):
    chunk_id: str
    title: str
    score: float


class ReportSchema(BaseModel):
    viability_score: int = Field(ge=0, le=100)
    risk_score: int = Field(ge=0, le=100)
    confidence: float = Field(ge=0.0, le=1.0)
    market_summary: str
    target_audience: str
    business_model: str
    key_assumptions: List[str]
    risks: List[RiskItem]
    recommendations: List[str]
    pivots: List[str]
    sources: List[SourceItem]


class AnalyzeIdeaRequest(BaseModel):
    idea_text: str
    industry: Optional[str] = None
    region: Optional[str] = None
    stage: Optional[str] = None


class AnalyzeIdeaResponse(BaseModel):
    idea_id: str
    report: ReportSchema
