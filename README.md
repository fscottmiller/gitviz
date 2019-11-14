# Kibana and Elastic - Containerized Config
Just a POC / test on setting Kibana configurations. 

# Starting
Just run `./start`
This will build the gitviz container (a Ruby program which queries GitHub for branch information on specified repos).
Because of limitations on the number of requests the GitHub API allows, you must enter your username and password.
If you don't have kibana:7.4.2 and elasticsearch:7.4.2 locally, they will be pulled and run.

# Configuration
Once everything is running, go to Kibana in your browser (http://localhost:5601). From there, go to Settings > Saved Objects. Select Import, then upload the file 'export.ndjson' from the kibana directory of this repository. Click OK, and you'll be set!

# Notes
The data collection stage (gitviz) is still very flaky. The API times out fairly often, which can break your data ingestion. However, the main point here was to show saved visualizations and dashboards; the data collection will come with time.