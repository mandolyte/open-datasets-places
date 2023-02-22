#!/bin/sh

go run createPleiadesInput.go -i ../../sources/pleiades-locations/pleiades.csv 




echo "Run the database imports"
echo NOTE!! cannot indent the sql commands
sqlite3 ../../places.db <<EoF
.echo on
drop table if exists pleiades_tbl;

.mode csv

.import pleiades_tbl.csv pleiades_tbl
select count(*) from pleiades_tbl;

.exit
EoF
