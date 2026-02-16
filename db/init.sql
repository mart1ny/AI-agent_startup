CREATE TABLE IF NOT EXISTS ideas (
    idea_id TEXT PRIMARY KEY,
    idea_text TEXT NOT NULL,
    industry TEXT,
    region TEXT,
    stage TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS reports (
    report_id TEXT PRIMARY KEY,
    idea_id TEXT NOT NULL REFERENCES ideas(idea_id),
    report_json JSONB NOT NULL,
    model_version TEXT NOT NULL,
    prompt_version TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS feedback (
    feedback_id SERIAL PRIMARY KEY,
    idea_id TEXT NOT NULL REFERENCES ideas(idea_id),
    rating INT NOT NULL,
    useful BOOLEAN NOT NULL,
    comment TEXT,
    success BOOLEAN,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS drift_metrics (
    metric_id SERIAL PRIMARY KEY,
    metric_date DATE NOT NULL,
    metric_name TEXT NOT NULL,
    metric_value DOUBLE PRECISION NOT NULL,
    model_version TEXT NOT NULL,
    prompt_version TEXT NOT NULL
);

INSERT INTO ideas (idea_id, idea_text, industry, region, stage, created_at) VALUES
('idea_001', 'AI помощник для юристов малого бизнеса', 'legal', 'EU', 'mvp', '2024-01-10 10:00:00'),
('idea_002', 'Платформа для анализа конкурентов в e-commerce', 'ecommerce', 'US', 'seed', '2024-01-11 10:00:00'),
('idea_003', 'Мобильный тренер по осанке на основе CV', 'health', 'RU', 'idea', '2024-01-12 10:00:00'),
('idea_004', 'B2B сервис выявления аномалий в логах', 'saas', 'EU', 'mvp', '2024-01-13 10:00:00'),
('idea_005', 'Маркетплейс краткосрочных курсов для HR', 'edtech', 'US', 'seed', '2024-01-14 10:00:00'),
('idea_006', 'Сервис проверки кредитного риска для SMB', 'fintech', 'EU', 'idea', '2024-01-15 10:00:00'),
('idea_007', 'Платформа для анализа спроса на жилье', 'proptech', 'US', 'mvp', '2024-01-16 10:00:00'),
('idea_008', 'Генератор маркетинговых офферов для агентств', 'marketing', 'EU', 'seed', '2024-01-17 10:00:00'),
('idea_009', 'Автоматизация рекрутинга для стартапов', 'hrtech', 'RU', 'mvp', '2024-01-18 10:00:00'),
('idea_010', 'Сервис аналитики churn для подписок', 'saas', 'US', 'idea', '2024-01-19 10:00:00');

INSERT INTO reports (report_id, idea_id, report_json, model_version, prompt_version, created_at) VALUES
('report_001', 'idea_001', '{"viability_score":72,"risk_score":35,"confidence":0.71,"market_summary":"Юрсервисы для SMB растут.","target_audience":"малый бизнес","business_model":"subscription","key_assumptions":["готовность платить","экономия времени"],"risks":[{"category":"legal","description":"регуляторные требования","severity":60}],"recommendations":["пилот с 5 компаниями"],"pivots":["нишевой фокус"],"sources":[{"chunk_id":"kb_001","title":"legal_smb.md","score":0.83}]}', 'llama.cpp-gguf', 'v1', '2024-01-10 10:05:00'),
('report_002', 'idea_002', '{"viability_score":68,"risk_score":40,"confidence":0.65,"market_summary":"Конкурентная аналитика востребована.","target_audience":"e-commerce команды","business_model":"tiered","key_assumptions":["данные доступны","чек средний"],"risks":[{"category":"market","description":"конкуренция","severity":70}],"recommendations":["узкая ниша"],"pivots":["фокус на брендах"],"sources":[{"chunk_id":"kb_014","title":"ecom_competitors.md","score":0.79}]}', 'llama.cpp-gguf', 'v1', '2024-01-11 10:05:00'),
('report_003', 'idea_003', '{"viability_score":55,"risk_score":55,"confidence":0.58,"market_summary":"Пользовательские устройства чувствительны к цене.","target_audience":"люди с сидячей работой","business_model":"one-time+upsell","key_assumptions":["доступ к камере","низкая цена"],"risks":[{"category":"tech","description":"точность CV","severity":65}],"recommendations":["MVP на iOS"],"pivots":["B2B офисы"],"sources":[{"chunk_id":"kb_022","title":"cv_posture.md","score":0.74}]}', 'llama.cpp-gguf', 'v1', '2024-01-12 10:05:00'),
('report_004', 'idea_004', '{"viability_score":77,"risk_score":30,"confidence":0.74,"market_summary":"B2B мониторинг логов стабилен.","target_audience":"devops команды","business_model":"subscription","key_assumptions":["есть бюджеты","быстрый пилот"],"risks":[{"category":"gtm","description":"длинные продажи","severity":45}],"recommendations":["интеграция с SIEM"],"pivots":["фокус на финтех"],"sources":[{"chunk_id":"kb_030","title":"log_anomaly.md","score":0.86}]}', 'llama.cpp-gguf', 'v1', '2024-01-13 10:05:00'),
('report_005', 'idea_005', '{"viability_score":60,"risk_score":50,"confidence":0.62,"market_summary":"HR ищет гибкие обучения.","target_audience":"HR менеджеры","business_model":"marketplace","key_assumptions":["наполнение каталога","повторные покупки"],"risks":[{"category":"market","description":"низкая маржинальность","severity":55}],"recommendations":["курсы от топ экспертов"],"pivots":["B2B пакеты"],"sources":[{"chunk_id":"kb_041","title":"hr_courses.md","score":0.71}]}', 'llama.cpp-gguf', 'v1', '2024-01-14 10:05:00');

INSERT INTO feedback (idea_id, rating, useful, comment, success, created_at) VALUES
('idea_001', 4, TRUE, 'Полезный отчёт', NULL, '2024-01-10 11:00:00'),
('idea_001', 5, TRUE, 'Точные риски', TRUE, '2024-01-11 11:00:00'),
('idea_002', 3, TRUE, 'Нужны примеры', NULL, '2024-01-11 11:10:00'),
('idea_003', 2, FALSE, 'Мало конкретики', NULL, '2024-01-12 11:00:00'),
('idea_004', 5, TRUE, 'Отлично', TRUE, '2024-01-13 11:00:00'),
('idea_005', 4, TRUE, 'Нормально', NULL, '2024-01-14 11:00:00'),
('idea_006', 3, TRUE, 'Есть вопросы', NULL, '2024-01-15 11:00:00'),
('idea_007', 4, TRUE, 'Хороший фокус', NULL, '2024-01-16 11:00:00');

INSERT INTO drift_metrics (metric_date, metric_name, metric_value, model_version, prompt_version) VALUES
('2024-01-10', 'psi_viability_score', 0.08, 'llama.cpp-gguf', 'v1'),
('2024-01-11', 'psi_risk_score', 0.06, 'llama.cpp-gguf', 'v1'),
('2024-01-12', 'csi_topics', 0.11, 'llama.cpp-gguf', 'v1');
