#!/bin/sh

splitcsv -c 1,6,7,8,12,13,15,16,17,19,22 \
    -i pleiades-locations.csv \
    -o pleiades_tbl.csv

echo "Run the database imports"
echo NOTE!! cannot indent the sql commands
sqlite3 ../../properNames.db <<EoF
.echo on
drop table if exists pleiades_tbl;

.mode csv

.import pleiades_tbl.csv pleiades_tbl
select count(*) from pleiades_tbl;

.exit
EoF

