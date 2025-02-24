CREATE TABLE IF NOT EXISTS agg_test.ask_fr_per_endpoint
(
    `dt_day_utc` Date,    
    `token` LowCardinality(String),
    `endpoint` LowCardinality(String),
    `count_of_requests` UInt32,
    `duration_avg_ms` UInt16,
    `duration_med_ms` UInt16,
    `q90_duration_ms` UInt16,
    `_calc_utc` UInt32
)
ENGINE = MergeTree
PARTITION BY toMonth(dt_day_utc)
PRIMARY KEY token
ORDER BY token
SETTINGS index_granularity = 8192;