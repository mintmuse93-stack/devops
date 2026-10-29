cat > logs.txt <<'EOF'
google,10,100,2025-11-03
yahoo,11,200,2025-11-03
google,10,150,2025-11-03
amazon,12,300,2025-11-04
yahoo,11,250,2025-11-04
EOF
===========================================
hadoop fs -mkdir -p /data/pig/simple_logs
hadoop fs -put logs.txt /data/pig/simple_logs/
==================================================
hadoop fs -ls /data/pig/simple_logs
=====================================
pig
===============================================
logs = LOAD '/data/pig/simple_logs/logs.txt'
USING PigStorage(',')
AS (
    site:chararray,
    hour_of_day:chararray,
    page_views:int,
    data_date:chararray
);
DUMP logs;

===========================================
g1 = GROUP logs BY (data_date, hour_of_day);
r1 = FOREACH g1 GENERATE
    group.data_date,
    group.hour_of_day,
    SUM(logs.page_views) AS total_views;
DUMP r1;
