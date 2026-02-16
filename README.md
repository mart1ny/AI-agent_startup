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
