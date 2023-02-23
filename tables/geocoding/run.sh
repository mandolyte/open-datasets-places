#!/bin/sh

echo "Run the database imports"
echo NOTE!! cannot indent the sql commands
sqlite3 ../../places.db <<EoF
.echo on
drop table if exists geocoding_json_tbl;
drop table if exists geocoding_tbl;
.mode csv
.separator |

.import ../../sources/Bible-Geocoding-Data/data/linked_data.txt geocoding_json_tbl
select count(*) from geocoding_json_tbl;

UPDATE geocoding_json_tbl
SET linked_data = '{}'
WHERE linked_data = "" or linked_data is null
;

-- now create a table without json
CREATE TABLE geocoding_tbl as
    select id, friendly_id, 
    json_extract(linked_data, '$.s3b25cf.id') as stepbible_id,
    json_extract(linked_data, '$.s7cc8b2.id') as wikidata_id,
    json_extract(linked_data, '$.s2428ed.id') as pleiades_id, 
    json_extract(linked_data, '$.s2428ed.data_url') as pleiades_url
    from geocoding_json_tbl 
;

select count(*) from geocoding_tbl;

.exit
EoF



