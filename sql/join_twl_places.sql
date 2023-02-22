select t.bcv_id, twlink, unique_name, strongs, latitude, longitude
from twl_tbl t
inner join sb_places_tbl s
on t.bcv_id = s.bcv_id
where unique_name like 'Mortar%'
;
