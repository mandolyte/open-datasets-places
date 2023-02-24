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
-- read the article for the city of Tyre
select file from tw_tbl
where category = 'names' and name = 'tyre'
;


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
-- link to the json for the page
https://pleiades.stoa.org/places/845754667/json

*/



/* Demo 3
    Open Bible Geocoding Dataset
    - has linkages to Wikidata, Pleiades, and StepBible!
*/
-- the raw data
select * from geocoding_json_tbl limit 5;

-- using JSON functions to extract data of interest
select 
    json_extract(linked_data, '$.s3b25cf.id')       as stepbible_id,
    json_extract(linked_data, '$.s7cc8b2.id')       as wikidata_id,
    json_extract(linked_data, '$.s2428ed.id')       as pleiades_id, 
    json_extract(linked_data, '$.s2428ed.data_url') as pleiades_url
from geocoding_json_tbl
where pleiades_id is not null
limit 5
;

-- from their "ancient" data
select * from geocoding_tbl 
where pleiades_id is not null
limit 10
;

-- let's find our friend Achzib
select * from geocoding_tbl 
where friendly_id like 'Achzib%'
;
/*
-- go to geocoding website
https://www.openbible.info/geo/ancient/ad0d82f/achzib-2

-- wikidata
https://www.wikidata.org/wiki/Q54991090
*/ 

-- now join to Step Bible data to get all scripture references
select g.id, g.friendly_id, g.wikidata_id, sb.unique_name, s.bcv_id, 
    sb.estrong, sb.dstrong, sb.original, sb.esv_name,
    sp.latitude, sp.longitude
from geocoding_tbl g
inner join sbps_has_bcv_rel s 
on s.unique_name = g.stepbible_id
inner join sbp_significance_tbl sb
on g.stepbible_id = sb.unique_name
inner join sb_places_tbl sp
on sb.unique_name = sp.unique_name
where friendly_id like 'Achzib%'
;


-- now convert to json array (missing outer []
select
json_object(
    'id',g.id,
    'friendly_id',g.friendly_id,
    'wikidata_id',g.wikidata_id,
    'stepbible_id',sb.unique_name,
    'stepbible_ref',s.bcv_id, 
    'estrong',sb.estrong,
    'dstrong',sb.dstrong,
    'original',sb.original,
    'esv_plus',sb.esv_name,
    'latitude',sp.latitude,
    'longitude',sp.longitude   
) 
from geocoding_tbl g
inner join sbps_has_bcv_rel s 
on s.unique_name = g.stepbible_id
inner join sbp_significance_tbl sb
on g.stepbible_id = sb.unique_name
inner join sb_places_tbl sp
on sb.unique_name = sp.unique_name
where friendly_id like 'Achzib%'
;

-- how about a JSON Lines format?
select json_array('id','friendly_id','wikidata_id','unique_name','bcv_id',
'estrong','dstrong','original','esv_name','latitude','longitude') as data
union all
select 
json_array(
    g.id,
    g.friendly_id,
    g.wikidata_id,
    sb.unique_name,
    s.bcv_id, 
    sb.estrong,
    sb.dstrong,
    sb.original,
    sb.esv_name,
    sp.latitude,
    sp.longitude   
)   
from geocoding_tbl g
inner join sbps_has_bcv_rel s 
on s.unique_name = g.stepbible_id
inner join sbp_significance_tbl sb
on g.stepbible_id = sb.unique_name
inner join sb_places_tbl sp
on sb.unique_name = sp.unique_name
where friendly_id like 'Achzib%'
;

