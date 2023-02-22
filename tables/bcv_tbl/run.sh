#!/bin/sh

# run the command to extract the data in normalized form
echo "Run the exract"
go run versificationToCSV.go 

echo "Run the database imports"
echo NOTE!! cannot indent the sql commands
sqlite3 ../../places.db <<EoF
.echo on
drop table if exists bcv_tbl;

.mode csv

.import bcv_tbl.csv bcv_tbl
select count(*) from bcv_tbl;

.exit
EoF



