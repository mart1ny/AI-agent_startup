# LLM-агент анализа стартап-идей + База знаний (RAG)

Минимальный MVP сервиса для анализа стартап-идей с RAG, отчётом в JSON и последующей инфраструктурой (Batch, Observability, CI/CD).

## Цели

- Принять описание идеи и вернуть структурированный отчёт.
- Сохранить результаты и метаданные.
- Подготовить фундамент под мониторинг качества и дрейфа.

## Структура

- `src/idea_service/domain` — доменные сущности.
- `src/idea_service/application` — use-cases.
- `src/idea_service/infrastructure` — адаптеры и хранилища.
- `src/idea_service/presentation` — API слой.

## Локальная база данных

1) Создать `.env` по примеру `.env.example`.
2) Запустить Postgres:
   `docker-compose up -d postgres`

## Быстрая проверка (локально)

1) Проверка Zvec:
   `PYTHONPATH=src python3 scripts/zvec_smoke.py`
2) Проверка Postgres (таблицы):
   `/Applications/Docker.app/Contents/Resources/bin/docker exec -it idea_postgres psql -U idea_user -d idea_service -c "\\dt"`
3) Проверка Postgres (данные):
   `/Applications/Docker.app/Contents/Resources/bin/docker exec -it idea_postgres psql -U idea_user -d idea_service -c "select count(*) from ideas;"`

## Наполнение данных

1) Postgres (доп. сидинг):
   `/Applications/Docker.app/Contents/Resources/bin/docker exec -i idea_postgres psql -U idea_user -d idea_service < db/seed.sql`
2) Zvec (база знаний):
   `PYTHONPATH=src python3 scripts/seed_zvec.py`

## Этапы разработки (статус)

- [x] Каркас Clean Architecture (слои и сущности)
- [x] Базовые Pydantic-схемы отчёта
- [x] Минимальный FastAPI app + /health
- [x] Zvec адаптер + smoke-тест
- [x] Postgres docker-compose + схема + синтетические данные
- [ ] Порты для репозиториев и LLM клиента
- [ ] Use-cases (Analyze/Get/Feedback/Drift)
- [ ] API эндпоинты: analyze/get/feedback + swagger
- [ ] Ингест базы знаний (чанкинг + embeddings + upsert в Zvec)
- [ ] Хранилища Postgres (репозитории)
- [ ] Метрики Prometheus + /metrics
- [ ] Airflow DAG: ingest KB (DockerOperator)
- [ ] Airflow DAG: drift (PSI/CSI, backfill)
- [ ] Dockerfile + uv.lock
- [ ] CI/CD: линтеры, тесты, coverage, build/push/deploy
- [ ] Observability: Prometheus/Grafana/alerts + Loki
- [ ] ADR + C4 + бизнес-документ
