CYBER INCIDENT INVESTIGATION – OPENSEARCH READY LAB
Incident 03: Ransomware Incident

WHAT IS ALREADY PREPARED
- OpenSearch + OpenSearch Dashboards configuration
- 1,000 events automatically imported
- 13 alerts automatically imported
- Two ready data views (index patterns):
    cyberlab-incident03-lite
    cyberlab-incident03-alerts-lite
- No manual index creation, mappings, Bulk API or Docker configuration is required.

ONE-TIME PREREQUISITE
Install and start Docker Desktop. Allocate at least 3 GB RAM to Docker if your installation allows resource limits.
Internet access is required the first time so Docker can download the official OpenSearch images.

WINDOWS – START
1. Start Docker Desktop and wait until it is ready.
2. Double-click START_LAB.bat.
3. On the first run, wait several minutes while images are downloaded.
4. Your browser will open OpenSearch Dashboards. If it does not, open:
   http://localhost:5601/app/discover

MAC / LINUX – START
Run: ./START_LAB.sh
Then open: http://localhost:5601/app/discover

FIRST SCREEN IN OPENSEARCH DASHBOARDS
1. Open Discover.
2. Select the EVENTS data view: cyberlab-incident03-lite
3. Set the absolute time range to cover:
   2026-12-02 05:55 UTC  →  2026-12-02 10:34 UTC
4. Start with simple filters such as user, host, src_ip, event_name, status, severity.
5. To inspect SIEM alerts, switch the data view to: cyberlab-incident03-alerts-lite

YOUR ASSIGNMENT
You are NOT expected to administer OpenSearch. Use it only to investigate the incident.
Create only the two visualizations requested in your assignment and add them to a small investigation dashboard.

STOP
Double-click STOP_LAB.bat (or run ./STOP_LAB.sh). The data volume is preserved.

RESET
Use RESET_LAB.bat / RESET_LAB.sh only if you want to return the lab to its initial state.

LOCAL LAB SAFETY
The OpenSearch Security plugin is intentionally disabled in this local teaching environment.
Do not expose ports 9200 or 5601 to the public internet.
