#!/bin/sh

echo "Run the database imports"
echo NOTE!! cannot indent the sql commands
sqlite3 ../../places.db <<EoF
.echo on
drop table if exists twl_tbl;

.mode csv

.import ../../sources/twl/twl.csv twl_tbl
select count(*) from twl_tbl;

.exit
EoF

