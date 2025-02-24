--Requires a new dictionary to parse UA can be found here: https://clickhouse.com/docs/en/sql-reference/dictionaries#regexp-tree-dictionary
INSERT INTO agg_test.ci_elastic_per_ua (dt_day_utc,token,ua, count_of_requests,sum_traffic_bytes,duration_avg_ms,duration_med_ms,q90_duration_ms,_calc_utc )

SELECT  toDate(dt_utc) as dt_day_utc ,
        replace(_token , '\0','')  as token,
        user_agent as ua,
        COUNT() as count_of_requests,
        SUM(body_len) as sum_traffic_bytes,
        AVG(duration_s*1000) as duration_avg_ms,
        quantile(0.5)(duration_s*1000) as duration_med_ms,
        quantile(0.9)(duration_s*1000) as q90_duration_ms,
        toUnixTimestamp(now()) as _calc_utc
FROM scaleflex_infra.cloudimg_elastic_logs_httpd
WHERE toDate(dt_utc) = yesterday()
GROUP BY dt_day_utc , token , user_agent 
ORDER BY dt_day_utc ASC;