from __future__ import annotations

import random

from idea_service.infrastructure.zvec_store import ZvecVectorStore
from idea_service.domain.ports import VectorDocument


def _random_vector(dim: int) -> list[float]:
    return [random.random() for _ in range(dim)]


def main() -> None:
    store = ZvecVectorStore(path="./local_zvec", collection_name="ideas", vector_dim=4)

    docs = [
        VectorDocument(doc_id="doc_1", vector=_random_vector(4), metadata={"title": "First"}),
        VectorDocument(doc_id="doc_2", vector=_random_vector(4), metadata={"title": "Second"}),
    ]
    store.upsert_documents(docs)

    query = _random_vector(4)
    results = store.query_similar(query, top_k=2)

    print("Results:")
    for res in results:
        print(res)


if __name__ == "__main__":
    main()
