/*
    Join place data with Translation Word Lists
*/

select t.bcv_id as "Reference",
t.twlink as "Translation Word Article", 
s.unique_name as "Step Bible Place Key",
s.latitude, s.longitude
from twl_tbl t
inner join sb_places_tbl s
on t.bcv_id = s.bcv_id
where s.unique_name like 'Achzib%'
order by s.unique_name
;
-- Google map link:
-- https://www.google.com/maps/@31.700000,35.000000,14z

-- Translation word article (based on "rc://" links):
-- https://git.door43.org/unfoldingWord/en_tw/src/branch/master/bible/names/tyre.md

-- Lookup the text online (in this ESV):
-- https://www.esv.org/jos.19.29

/*
    Look up Pleiades data 
    (using the Achzib example above and short lat/long values)
*/
select featuretype, mindate, maxdate, timeperiodskeys, pid from pleiades_tbl p 
where p.lat = "33.0" and p.long = "35.1" 
;

-- Link to Pleiades Website Article
-- https://pleiades.stoa.org/places/845754667