INSERT INTO agg_test.cdn_per_country (dt_day_utc,token, country, country_code, count_of_requests,sum_traffic_bytes,ttfb_avg_ms,ttfb_med_ms,q90_ttfb_ms,ttlb_avg_ms,ttlb_med_ms,q90_ttlb_ms,_calc_utc )

SELECT  toDate(dt_utc) as dt_day_utc ,
        replace(_cdn_token , '\0','')  as token,
        dictGetString('default.geoip_country_locations_en', 'country_name', toUInt64(COALESCE(NULLIF(dictGetUInt32('default.geoip_country_blocks_ipv6', 'geoname_id', tuple(IPv6StringToNum(u_ip))), 0),dictGetUInt32('default.geoip_country_blocks_ipv4', 'geoname_id', tuple(IPv4StringToNum(u_ip)))))) AS country_name,
        dictGetString('default.geoip_country_locations_en', 'country_iso_code', toUInt64(COALESCE(NULLIF(dictGetUInt32('default.geoip_country_blocks_ipv6', 'geoname_id', tuple(IPv6StringToNum(u_ip))), 0),dictGetUInt32('default.geoip_country_blocks_ipv4', 'geoname_id', tuple(IPv4StringToNum(u_ip)))))) as country_code,
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
GROUP BY dt_day_utc , token , country_name , country_code 
ORDER BY dt_day_utc ASC;