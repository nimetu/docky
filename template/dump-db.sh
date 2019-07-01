#!/bin/sh

DATE=$(date +"%Y%m%d-%H%M%S")
DB="nel nel_tool ring_shard01 nel_ams nel_ams_lib"

for db in $DB; do
	mysqldump --skip-dump-date --skip-opt --add-drop-database ${db} > ${DATE}_db_${db}.sql
done

