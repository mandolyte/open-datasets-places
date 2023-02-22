create view sb_shortened_latlong_vw as 

select unique_name, round(lat,1) as lat, round(long,1) as long
from (
	select unique_name, 
	cast(latitude as real) as lat, 
	cast(longitude as real) as long
	from sb_places_tbl 
)
;