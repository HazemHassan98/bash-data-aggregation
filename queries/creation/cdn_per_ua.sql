--Requires a new dictionary to parse UA can be found here: https://clickhouse.com/docs/en/sql-reference/dictionaries#regexp-tree-dictionary
CREATE TABLE IF NOT EXISTS agg_test.cdn_per_ua
(
    `dt_day_utc` Date,
    `token` LowCardinality(String),
    `ua` LowCardinality(String),
    `count_of_requests` UInt32,
    `sum_traffic_bytes` UInt32,
    `ttfb_avg_ms` UInt16,
    `ttfb_med_ms` UInt16,
    `q90_ttfb_ms` UInt16,
    `ttlb_avg_ms` UInt16,
    `ttlb_med_ms` UInt16,
    `q90_ttlb_ms` UInt16,
    `_calc_utc` UInt32
)
ENGINE = MergeTree
PARTITION BY toMonth(dt_day_utc)
PRIMARY KEY token
ORDER BY token
SETTINGS index_granularity = 8192;



