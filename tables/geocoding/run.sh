#!/bin/sh

echo "Run the database imports"
echo NOTE!! cannot indent the sql commands
sqlite3 ../../places.db <<EoF
.echo on
drop table if exists geocoding_tbl;
.mode csv
.separator |

.import ../../sources/Bible-Geocoding-Data/data/linked_data.tsv geocoding_tbl
select count(*) from geocoding_tbl;

.exit
EoF



