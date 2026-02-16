from __future__ import annotations

import os
from typing import Iterable, List, Optional

import zvec

from idea_service.domain.ports import VectorDocument, VectorSearchResult, VectorStore


class ZvecVectorStore(VectorStore):
    def __init__(self, path: str, collection_name: str, vector_dim: int) -> None:
        schema = zvec.CollectionSchema(
            name=collection_name,
            vectors=zvec.VectorSchema("embedding", zvec.DataType.VECTOR_FP32, vector_dim),
        )
        if os.path.exists(path):
            self._collection = zvec.open(path=path)
        else:
            self._collection = zvec.create_and_open(path=path, schema=schema)

    def upsert_documents(self, documents: Iterable[VectorDocument]) -> None:
        docs = []
        for doc in documents:
            docs.append(
                zvec.Doc(
                    id=doc.doc_id,
                    vectors={"embedding": doc.vector},
                    fields=doc.metadata or None,
                )
            )
        if docs:
            self._collection.upsert(docs)

    def query_similar(self, query_vector: List[float], top_k: int) -> List[VectorSearchResult]:
        results = self._collection.query(
            zvec.VectorQuery("embedding", vector=query_vector),
            topk=top_k,
        )
        parsed: List[VectorSearchResult] = []
        for item in results:
            if isinstance(item, zvec.Doc):
                parsed.append(
                    VectorSearchResult(
                        doc_id=item.id,
                        score=float(item.score or 0.0),
                        metadata=item.fields or None,
                    )
                )
                continue
            metadata = {k: v for k, v in item.items() if k not in {"id", "score"}}
            parsed.append(
                VectorSearchResult(
                    doc_id=item.get("id", ""),
                    score=float(item.get("score", 0.0)),
                    metadata=metadata or None,
                )
            )
        return parsed

    def delete_by_ids(self, doc_ids: Iterable[str]) -> None:
        for doc_id in doc_ids:
            self._collection.delete(doc_id)

    def get_by_id(self, doc_id: str) -> Optional[VectorDocument]:
        doc = self._collection.fetch(doc_id)
        if not doc:
            return None
        if isinstance(doc, zvec.Doc):
            vector = None
            if doc.vectors:
                vector = doc.vectors.get("embedding")
            if vector is None:
                return None
            return VectorDocument(
                doc_id=doc.id,
                vector=list(vector),
                metadata=doc.fields or None,
            )
        vectors = doc.get("vectors") or {}
        vector = vectors.get("embedding")
        if vector is None:
            return None
        metadata = {k: v for k, v in doc.items() if k not in {"id", "vectors"}}
        return VectorDocument(doc_id=doc.get("id", ""), vector=list(vector), metadata=metadata or None)
