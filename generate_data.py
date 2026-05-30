import pandas as pd
import random
from datetime import datetime, timedelta

# Set up parameters for simulation
vessels = [
    "Maersk Pangani", "MSC Tanzanite", "CMA CGM Kilwa", 
    "Grimaldi Kurasini", "Hoegh Autoliners", "Pacific Kigamboni",
    "Ocean Cargo Dar", "Safari Express", "Zanzibar Star", "Kilimanjaro Titan"
]
cargo_types = ["Container", "Liquid Bulk", "Dry Bulk", "Ro-Ro (Vehicles)"]
bottlenecks = ["Customs Clearance Delay", "Crane Mechanical Fault", "Berth Congestion", "None"]

data = []
start_date = datetime(2026, 1, 1)

# Generate 200 operational tracking records
for i in range(200):
    vessel = random.choice(vessels)
    cargo = random.choice(cargo_types)
    
    # Simulate time windows
    arrival = start_date + timedelta(days=random.randint(0, 120), hours=random.randint(0, 23))
    
    # Standard operational processing hours based on cargo type
    base_hours = {"Container": 18, "Liquid Bulk": 36, "Dry Bulk": 48, "Ro-Ro (Vehicles)": 12}
    processing_time = base_hours[cargo] + random.randint(-4, 6)
    
    # Simulate an unexpected delay factor
    delay_reason = random.choice(bottlenecks)
    delay_hours = 0 if delay_reason == "None" else random.randint(4, 24)
    
    departure = arrival + timedelta(hours=(processing_time + delay_hours))
    total_turnaround_hours = (departure - arrival).total_seconds() / 3600
    
    data.append([
        f"TX-{1000+i}", vessel, cargo, 
        arrival.strftime('%Y-%m-%d %H:%M'), 
        departure.strftime('%Y-%m-%d %H:%M'), 
        round(total_turnaround_hours, 2), 
        delay_hours, delay_reason
    ])

# Structure into a clean DataFrame
columns = ["Transaction_ID", "Vessel_Name", "Cargo_Type", "Arrival_Time", "Departure_Time", "Turnaround_Hours", "Delay_Hours", "Primary_Bottleneck"]
df = pd.DataFrame(data, columns=columns)

# Save as a clean CSV database seed file
df.to_csv("port_operations_logistics.csv", index=False)
print("🎯 Dataset successfully generated and saved as 'port_operations_logistics.csv'!")

