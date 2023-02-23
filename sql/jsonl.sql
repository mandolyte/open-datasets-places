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
