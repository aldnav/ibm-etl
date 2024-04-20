#!/usr/bin/env bash
# Extract
# Download
wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"
# Unzip the file to extract the .txt file.
gunzip -f web-server-access-log.txt.gz

# Transform
#   Change delimiter # to ,
echo "Transform delimiter"
tr "#" "," < web-server-access-log.txt > web-server-access-log.csv

# Transform
#   Only need timestamp, latitude, longitude, visitorid
echo "Transform / Extract only need first four fields"
cut -d "," -f 1-4 < web-server-access-log.csv > extracted-data.txt

# Load
# Load data to database
echo "Loading data to database"
echo "\c template1;\COPY access_log FROM '/home/project/extracted-data.txt' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost
