INSERT INTO agg_test.hexa_per_httpcode (dt_day_utc,token, http_code, count_of_requests,sum_traffic_bytes,duration_avg_ms,duration_med_ms,q90_duration_ms,_calc_utc )

SELECT  toDate(dt_utc) as dt_day_utc ,
        replace(_token , '\0','')  as token,
        http_code as http_code,
        COUNT() as count_of_requests,
        SUM(body_len) as sum_traffic_bytes,
        AVG(duration_ms) as duration_avg_ms,
        quantile(0.5)(duration_ms) as duration_med_ms,
        quantile(0.9)(duration_ms) as q90_duration_ms,
        toUnixTimestamp(now()) as _calc_utc
FROM scaleflex_infra.hexa_logs_httpd
WHERE toDate(dt_utc) = yesterday()
GROUP BY dt_day_utc , token , http_code
ORDER BY dt_day_utc ASC;