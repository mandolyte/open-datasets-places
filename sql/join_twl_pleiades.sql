with twl_sb_data as (
    select t.bcv_id, twlink, unique_name, strongs, latitude, longitude
    from twl_tbl t
    inner join sb_places_tbl s
    on t.bcv_id = s.bcv_id
    where unique_name like 'Mortar%'
)
select distinct twl.unique_name,pl.pid 
from twl_sb_data twl 

inner join sb_shortened_latlong_vw sb
on twl.unique_name = sb.unique_name

inner join pleiades_shortened_latlong_vw pl 
on sb.lat = pl.lat and sb.long = pl.long
;
