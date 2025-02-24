INSERT INTO agg_test.ask_fr_per_endpoint (dt_day_utc,token, endpoint,count_of_requests,duration_avg_ms,duration_med_ms,q90_duration_ms,_calc_utc )

SELECT  toDate(created_on) as dt_day_utc ,
        replace(token , '\0','') as token,
        extract(request_meta,'"type": "(.*?)"') AS endpoint ,
        COUNT() as count_of_requests,
        AVG(age('millisecond',created_on,finished_on)) as duration_avg_ms,
        quantile(0.5)(age('millisecond',created_on,finished_on)) as duration_med_ms,
        quantile(0.9)(age('millisecond',created_on,finished_on)) as q90_duration_ms,
        toUnixTimestamp(now()) as _calc_utc
FROM scaleflex_infra.ask_filerobot_logs_v2
WHERE toDate(created_on) = yesterday()
GROUP BY dt_day_utc , token , endpoint
ORDER BY dt_day_utc ASC;