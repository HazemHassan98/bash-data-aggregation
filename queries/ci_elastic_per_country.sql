INSERT INTO agg_test.ci_elastic_per_country (dt_day_utc,token, country, country_code, count_of_requests,sum_traffic_bytes,duration_avg_ms,duration_med_ms,q90_duration_ms,_calc_utc )

SELECT  toDate(dt_utc) as dt_day_utc ,
        replace(_token , '\0','')  as token,
        dictGetString('default.geoip_country_locations_en', 'country_name', toUInt64(COALESCE(NULLIF(dictGetUInt32('default.geoip_country_blocks_ipv6', 'geoname_id', tuple(IPv6StringToNum(client_ip))), 0),dictGetUInt32('default.geoip_country_blocks_ipv4', 'geoname_id', tuple(IPv4StringToNum(client_ip)))))) AS country_name,
        dictGetString('default.geoip_country_locations_en', 'country_iso_code', toUInt64(COALESCE(NULLIF(dictGetUInt32('default.geoip_country_blocks_ipv6', 'geoname_id', tuple(IPv6StringToNum(client_ip))), 0),dictGetUInt32('default.geoip_country_blocks_ipv4', 'geoname_id', tuple(IPv4StringToNum(client_ip)))))) as country_code,
        COUNT() as count_of_requests,
        SUM(body_len) as sum_traffic_bytes,
        AVG(duration_s*1000) as duration_avg_ms,
        quantile(0.5)(duration_s*1000) as duration_med_ms,
        quantile(0.9)(duration_s*1000) as q90_duration_ms,
        toUnixTimestamp(now()) as _calc_utc
FROM scaleflex_infra.cloudimg_elastic_logs_httpd
WHERE toDate(dt_utc) = yesterday()
GROUP BY dt_day_utc , token , country_name , country_code 
ORDER BY dt_day_utc ASC;