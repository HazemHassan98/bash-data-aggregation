INSERT INTO agg_test.cdn_per_uri (dt_day_utc,token, uri, count_of_requests,sum_traffic_bytes,ttfb_avg_ms,ttfb_med_ms,q90_ttfb_ms,ttlb_avg_ms,ttlb_med_ms,q90_ttlb_ms,_calc_utc )

SELECT  toDate(dt_utc) as dt_day_utc ,
        replace(_cdn_token , '\0','')  as token,
        u_uri as uri,
        COUNT() as count_of_requests,
        SUM(u_bytes) as sum_traffic_bytes,
        AVG(u_ttfb_ms) as ttfb_avg_ms,
        quantile(0.5)(u_ttfb_ms) as ttfb_med_ms,
        quantile(0.9)(u_ttfb_ms) as q90_ttfb_ms,
        AVG(u_ttlb_ms) as ttlb_avg_ms,
        quantile(0.5)(u_ttlb_ms) as ttlb_med_ms,
        quantile(0.9)(u_ttlb_ms) as q90_ttlb_ms,
        toUnixTimestamp(now()) as _calc_utc
FROM scaleflex_infra.cdn_logs___unified_view
WHERE toDate(dt_utc) = yesterday()
GROUP BY dt_day_utc , token , uri
ORDER BY dt_day_utc ASC;