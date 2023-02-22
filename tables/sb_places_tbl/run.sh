#!/bin/sh

# run the command to extract the data in normalized form
echo "Run the exract"
go run extractPlaces.go \
    -i ../../sources/stepbible/properNames.tsv




echo "Run the database imports"
echo NOTE!! cannot indent the sql commands
sqlite3 ../../places.db <<EoF
.echo on
drop table if exists sb_places_tbl;
drop table if exists sbp_significance_tbl;
drop table if exists sbps_has_bcv_rel;

.mode csv

.import sb_places_tbl.csv sb_places_tbl
select count(*) from sb_places_tbl;

.import sbp_significance_tbl.csv sbp_significance_tbl
select count(*) from sbp_significance_tbl;

.import sbps_has_bcv_rel.csv sbps_has_bcv_rel
select count(*) from sbps_has_bcv_rel;

.exit
EoF



