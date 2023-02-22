select sb.unique_name, pl.pid, sb.lat, sb.long
from sb_shortened_latlong_vw sb
inner join pleiades_shortened_latlong_vw pl
on sb.lat = pl.lat and sb.long = pl.long
where sb.unique_name like 'Zoar%'
;


-- sqlite> .read views/test_view_join.sql
-- unique_name|pid|lat|long
-- Zoar@Gen.13.10|/places/697729|30.9|35.4
-- https://www.google.com/maps/search/?api=1&query=30.9,35.4 
-- https://www.google.com/maps/@30.9,35.4,9z
-- https://pleiades.stoa.org/places/697729