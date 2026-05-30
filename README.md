# Maritime Logistics & Port Efficiency Analyzer

A local data engineering and analytics workspace built to ingest, store, and analyze port operational data, identifying critical supply chain bottlenecks and vessel turnaround performance.

## 🛠️ Tech Stack
* **Language:** Python 3 (Data Generation)
* **Database Engine:** MariaDB / MySQL (Relational Warehousing)
* **Environment:** Linux CLI (Termux)
* **Version Control:** Git & GitHub

## 📊 Core Data Insights Established
Based on the initial analysis of 200 operational tracking records, the following efficiency metrics were uncovered:
1. **Primary Bottleneck:** *Customs Clearance Delays* represent the highest impact friction point, causing the greatest volume of total lost operational hours.
2. **Turnaround Trends:** *Dry Bulk* vessels experience the longest average processing windows, averaging significantly higher turnaround times compared to Container or Ro-Ro shipping.
3. **Operational Anomalies:** Successfully flagged high-impact delays exceeding 15 hours for targeted infrastructure auditing.

## 💾 Database Schema & Sample Queries
The repository includes `analytics_queries.sql`, which defines the relational schema (`port_operations`) and contains production queries for:
* Aggregating total lost hours by bottleneck type.
* Profiling average turnaround and delay metrics by vessel cargo class.
* Audit logging high-impact delays.
# -logistics-efficiency-analyzer
