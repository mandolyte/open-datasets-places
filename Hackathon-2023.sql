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
-- Google map link
-- https://www.google.com/maps/@31.700000,35.000000,14z
Note 