-- ====================================================================
-- PROJECT 2: INFRASTRUCTURE ASSET INTEGRITY & CORROSION TRACKER
-- DESCRIPTION: Relational database tracking structural degradation.
-- ====================================================================

-- 1. Schema Creation
CREATE TABLE IF NOT EXISTS structural_components (
    component_id INT AUTO_INCREMENT PRIMARY KEY,
    component_name VARCHAR(100) NOT NULL,
    location_zone VARCHAR(50) NOT NULL,
    material_type VARCHAR(50) NOT NULL,
    original_thickness_mm DECIMAL(5,2) NOT NULL,
    installation_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS thickness_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    component_id INT,
    inspection_date DATE NOT NULL,
    measured_thickness_mm DECIMAL(5,2) NOT NULL,
    inspector_name VARCHAR(50),
    FOREIGN KEY (component_id) REFERENCES structural_components(component_id) ON DELETE CASCADE
);

-- 2. Analytical Query: Relational Thickness Loss Join
SELECT 
    c.component_name,
    c.location_zone,
    c.original_thickness_mm,
    l.inspection_date,
    l.measured_thickness_mm,
    (c.original_thickness_mm - l.measured_thickness_mm) AS total_metal_loss_mm
FROM structural_components c
INNER JOIN thickness_logs l ON c.component_id = l.component_id
ORDER BY c.component_name, l.inspection_date;

-- 3. Advanced Query: Dynamic Annual Corrosion Rate Modeling
SELECT 
    c.component_name,
    c.location_zone,
    l.inspection_date,
    (c.original_thickness_mm - l.measured_thickness_mm) AS total_loss_mm,
    ROUND(
        (c.original_thickness_mm - l.measured_thickness_mm) / 
        (TIMESTAMPDIFF(DAY, c.installation_date, l.inspection_date) / 365.25), 
        3
    ) AS annual_corrosion_rate_mm_year
FROM structural_components c
INNER JOIN thickness_logs l ON c.component_id = l.component_id
ORDER BY annual_corrosion_rate_mm_year DESC;

