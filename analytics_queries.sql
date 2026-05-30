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

