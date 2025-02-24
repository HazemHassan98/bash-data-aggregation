CREATE TABLE IF NOT EXISTS agg_test.fr_iplb_per_vhost
(
    `dt_day_utc` Date,    
    `token` LowCardinality(String),
    `vhost` LowCardinality(String),
    `count_of_requests` UInt32,
    `sum_traffic_bytes` UInt32,
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


