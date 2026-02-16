from __future__ import annotations

from fastapi import FastAPI


def create_app() -> FastAPI:
    app = FastAPI(title="Idea Analysis Service")

    @app.get("/health")
    def health() -> dict:
        return {"status": "ok"}

    return app
