/*
    step bible queries
*/

-- for word map, predictive work alignment
select original, esv_name
from sbp_significance_tbl
;


select * from sbps_has_bcv_rel
;

select * from sbps_has_bcv_rel 
where to_bcv_id not in 
(
    select bcv_id from bcv_tbl
)
;

select distinct book_id from bcv_tbl
;

select count(*) from sbps_has_bcv_rel
where to_bcv_id glob '*e'
or to_bcv_id glob '*d' 
or to_bcv_id glob '*c'
or to_bcv_id glob '*b'
or to_bcv_id glob '*a'
;

-- test regex
select * from sb_places_tbl
where to_bcv_id regexp '[a-z]$'
;

-- test regex
select * from sbps_has_bcv_rel
where to_bcv_id regexp '[a-z]$'
;

select json_object(from_unique_name, to_bcv_id) 
from sbps_has_bcv_rel
;


/*
    geocoding queries

*/
-- this seems to work
select json(linked_data) 
from geocoding_tbl limit 5
;


-- this converts it to a well-formed JSON array
select json_array( json(linked_data) )
from geocoding_tbl limit 5
;

-- this extracts the step bible key "unique name"
select json_extract(linked_data, '$.s3b25cf.id')
from geocoding_tbl
limit 5
;

-- let's add Wiki data
select 
json_extract(linked_data, '$.s3b25cf.id'),
json_extract(linked_data, '$.s7cc8b2.id')
from geocoding_tbl
limit 5
;

-- add pleiades
select 
json_extract(linked_data, '$.s3b25cf.id') as stepbible_id,
json_extract(linked_data, '$.s7cc8b2.id') as wikidata_id,
json_extract(linked_data, '$.s2428ed.id') as pleiades_id, 
json_extract(linked_data, '$.s2428ed.data_url') pleiades_url

from geocoding_tbl
where pleiades_id is not null
limit 5
;

-- are there any dups in the "friendly_id" key?
select friendly_id, count(*)
from geocoding_tbl
group by friendly_id
having count(*) > 1
;
-- no results, so looks good!

