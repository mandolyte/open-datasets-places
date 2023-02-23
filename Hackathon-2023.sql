/* Demo 1
    Join place data with Translation Word Lists
*/

select t.bcv_id as "Reference",
t.twlink as "Translation Word Article", 
t.OrigWords as "TWL Original Word",
sb.original as "SB Original Word",
sb.esv_name as "SB ESV Name",
s.unique_name as "Step Bible Place Key",
s.latitude, s.longitude
from twl_tbl t
inner join sb_places_tbl s
on t.bcv_id = s.bcv_id
inner join sbp_significance_tbl sb
on s.unique_name = sb.unique_name
where s.unique_name like 'Achzib%'
order by s.unique_name
;
/*
-- Google map link:
https://www.google.com/maps/@31.700000,35.000000,10z

-- Translation word article (based on "rc://" links):
https://git.door43.org/unfoldingWord/en_tw/src/branch/master/bible/names/tyre.md
https://git.door43.org/unfoldingWord/en_tw/raw/branch/master/bible/names/tyre.md

-- Lookup the text online
https://www.esv.org/jos.19.29
https://www.stepbible.org/?q=version=KJV|reference=jos.19.29;
*/



/* Demo 2
    Look up Pleiades data 
    (using the Achzib example above and short lat/long values)
*/
select featuretype, mindate, maxdate, timeperiodskeys, pid 
from pleiades_tbl p 
where p.lat = "33.0" and p.long = "35.1" 
;
/*
-- Link to Pleiades Website Article
https://pleiades.stoa.org/places/845754667
*/



/* Demo 3
    Open Bible Geocoding Dataset
    - has linkages to Wikidata, Pleiades, and StepBible!
*/
-- from their "ancient" data
select * from geocoding_tbl limit 10
;

-- using the JSON functions
select 
    json_extract(linked_data, '$.s3b25cf.id')       as stepbible_id,
    json_extract(linked_data, '$.s7cc8b2.id')       as wikidata_id,
    json_extract(linked_data, '$.s2428ed.id')       as pleiades_id, 
    json_extract(linked_data, '$.s2428ed.data_url') as pleiades_url
from geocoding_tbl
where pleiades_id is not null
limit 5
;
/*
-- wikidata
https://www.wikidata.org/wiki/Q204772

-- pleiades
https://pleiades.stoa.org/places/981502
-- In JSON
https://pleiades.stoa.org/places/981502/json
*/ 

