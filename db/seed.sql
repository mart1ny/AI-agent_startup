INSERT INTO ideas (idea_id, idea_text, industry, region, stage, created_at) VALUES
('idea_011', 'Сервис подбора поставщиков для ресторанов', 'foodtech', 'EU', 'mvp', '2024-01-20 10:00:00'),
('idea_012', 'B2B платформа оценки ESG рисков', 'fintech', 'US', 'seed', '2024-01-21 10:00:00'),
('idea_013', 'Аналитика маркетинговых креативов для брендов', 'marketing', 'EU', 'idea', '2024-01-22 10:00:00'),
('idea_014', 'Автоматизация финансовой отчётности для SMB', 'fintech', 'RU', 'mvp', '2024-01-23 10:00:00'),
('idea_015', 'Платформа управления знаниями для поддержки', 'saas', 'US', 'seed', '2024-01-24 10:00:00'),
('idea_016', 'Сервис планирования логистики для ритейла', 'logistics', 'EU', 'mvp', '2024-01-25 10:00:00'),
('idea_017', 'AI скрининг кандидатов для массового найма', 'hrtech', 'US', 'seed', '2024-01-26 10:00:00'),
('idea_018', 'Сервис предупреждения выгорания в командах', 'health', 'EU', 'idea', '2024-01-27 10:00:00'),
('idea_019', 'Платформа обучения по кибербезопасности', 'edtech', 'US', 'seed', '2024-01-28 10:00:00'),
('idea_020', 'Анализ цен на рынке аренды', 'proptech', 'RU', 'mvp', '2024-01-29 10:00:00');

INSERT INTO reports (report_id, idea_id, report_json, model_version, prompt_version, created_at) VALUES
('report_006', 'idea_011', '{"viability_score":64,"risk_score":46,"confidence":0.6,"market_summary":"Ресторанный рынок чувствителен к цене.","target_audience":"рестораны","business_model":"subscription","key_assumptions":["доступ к прайсам","качество поставщиков"],"risks":[{"category":"market","description":"низкая маржа","severity":55}],"recommendations":["пилот в одном городе"],"pivots":["фокус на сетях"],"sources":[{"chunk_id":"kb_003","title":"supply_chain.md","score":0.72}]}', 'llama.cpp-gguf', 'v1', '2024-01-20 10:05:00'),
('report_007', 'idea_012', '{"viability_score":70,"risk_score":38,"confidence":0.68,"market_summary":"ESG комплаенс усиливается.","target_audience":"финтех компании","business_model":"tiered","key_assumptions":["регуляторный спрос","доступ к данным"],"risks":[{"category":"legal","description":"регуляторные изменения","severity":62}],"recommendations":["MVP для одного сектора"],"pivots":["консалтинг+SaaS"],"sources":[{"chunk_id":"kb_010","title":"esg_risk.md","score":0.8}]}', 'llama.cpp-gguf', 'v1', '2024-01-21 10:05:00'),
('report_008', 'idea_013', '{"viability_score":58,"risk_score":52,"confidence":0.57,"market_summary":"Креативы требуют постоянного тестирования.","target_audience":"маркетинг команды","business_model":"usage-based","key_assumptions":["данные креативов","интеграции"],"risks":[{"category":"tech","description":"качество распознавания","severity":58}],"recommendations":["интеграция с Ad платформами"],"pivots":["фокус на e-commerce"],"sources":[{"chunk_id":"kb_012","title":"ad_creatives.md","score":0.69}]}', 'llama.cpp-gguf', 'v1', '2024-01-22 10:05:00'),
('report_009', 'idea_014', '{"viability_score":73,"risk_score":33,"confidence":0.72,"market_summary":"SMB ищут автоматизацию финансов.","target_audience":"малый бизнес","business_model":"subscription","key_assumptions":["простая интеграция","экономия времени"],"risks":[{"category":"gtm","description":"длинные продажи","severity":45}],"recommendations":["партнёрства с бухгалтерами"],"pivots":["нишевые сегменты"],"sources":[{"chunk_id":"kb_015","title":"finance_ops.md","score":0.77}]}', 'llama.cpp-gguf', 'v1', '2024-01-23 10:05:00'),
('report_010', 'idea_015', '{"viability_score":66,"risk_score":44,"confidence":0.64,"market_summary":"Снижение нагрузки на поддержку важно.","target_audience":"службы поддержки","business_model":"subscription","key_assumptions":["контент базы знаний","быстрый поиск"],"risks":[{"category":"tech","description":"качество поиска","severity":50}],"recommendations":["начать с FAQ"],"pivots":["фокус на SaaS"],"sources":[{"chunk_id":"kb_020","title":"support_kb.md","score":0.7}]}', 'llama.cpp-gguf', 'v1', '2024-01-24 10:05:00');

INSERT INTO feedback (idea_id, rating, useful, comment, success, created_at) VALUES
('idea_011', 4, TRUE, 'Нормальный отчёт', NULL, '2024-01-20 11:00:00'),
('idea_012', 5, TRUE, 'Полезные риски', TRUE, '2024-01-21 11:00:00'),
('idea_013', 3, TRUE, 'Нужны примеры', NULL, '2024-01-22 11:00:00'),
('idea_014', 5, TRUE, 'Точно описано', TRUE, '2024-01-23 11:00:00'),
('idea_015', 4, TRUE, 'Хорошо', NULL, '2024-01-24 11:00:00'),
('idea_016', 3, FALSE, 'Мало деталей', NULL, '2024-01-25 11:00:00'),
('idea_017', 4, TRUE, 'Полезно', NULL, '2024-01-26 11:00:00'),
('idea_018', 2, FALSE, 'Слабо', NULL, '2024-01-27 11:00:00');

INSERT INTO drift_metrics (metric_date, metric_name, metric_value, model_version, prompt_version) VALUES
('2024-01-20', 'psi_viability_score', 0.09, 'llama.cpp-gguf', 'v1'),
('2024-01-21', 'psi_risk_score', 0.07, 'llama.cpp-gguf', 'v1'),
('2024-01-22', 'csi_topics', 0.12, 'llama.cpp-gguf', 'v1'),
('2024-01-23', 'csi_risk_categories', 0.1, 'llama.cpp-gguf', 'v1');
