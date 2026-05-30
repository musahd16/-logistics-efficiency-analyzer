-- Query 1: Average Delays by Bottleneck Type
SELECT 
    primary_bottleneck,
    COUNT(*) as total_incidents,
    ROUND(AVG(delay_hours), 2) as avg_delay_hours,
    ROUND(SUM(delay_hours), 2) as total_lost_hours
FROM port_operations
GROUP BY primary_bottleneck
ORDER BY avg_delay_hours DESC;

-- Query 2: Turnaround Efficiency by Cargo Type
SELECT 
    cargo_type,
    COUNT(*) as vessel_count,
    ROUND(AVG(turnaround_hours), 2) as avg_turnaround_hours,
    ROUND(AVG(delay_hours), 2) as avg_delay_hours
FROM port_operations
GROUP BY cargo_type
ORDER BY avg_turnaround_hours DESC;

-- Query 3: High-Impact Delay Flagging (Audit Log)
SELECT 
    transaction_id, 
    vessel_name, 
    cargo_type, 
    primary_bottleneck, 
    delay_hours 
FROM port_operations 
WHERE delay_hours > 15.00 AND primary_bottleneck != 'None'
ORDER BY delay_hours DESC;

-- Query 4: Rank delay severity within cargo categories (Window Function)
SELECT 
    cargo_type,
    vessel_name,
    delay_hours,
    DENSE_RANK() OVER (PARTITION BY cargo_type ORDER BY delay_hours DESC) AS severity_rank
FROM port_operations
WHERE primary_bottleneck != 'None'
LIMIT 15;

-- Query 5: Categorizing delay incident severity (Conditional Aggregation)
SELECT 
    primary_bottleneck,
    COUNT(*) AS total_incidents,
    SUM(CASE WHEN delay_hours > 20 THEN 1 ELSE 0 END) AS critical_delays,
    SUM(CASE WHEN delay_hours BETWEEN 10 AND 20 THEN 1 ELSE 0 END) AS major_delays,
    SUM(CASE WHEN delay_hours < 10 THEN 1 ELSE 0 END) AS minor_delays
FROM port_operations
GROUP BY primary_bottleneck
ORDER BY total_incidents DESC;

