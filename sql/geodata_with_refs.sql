-- scripture references
with geodata as (
    select friendly_id, 
    json_extract(linked_data, '$.s3b25cf.id') as stepbible_id,
    json_extract(linked_data, '$.s7cc8b2.id') as wikidata_id,
    json_extract(linked_data, '$.s2428ed.id') as pleiades_id, 
    json_extract(linked_data, '$.s2428ed.data_url') pleiades_url
    from geocoding_tbl 
    where friendly_id like 'Achzib%'
)
select bcv_id, g.friendly_id, g.stepbible_id, g.wikidata_id 
from sbps_has_bcv_rel
inner join geodata g 
on unique_name = g.stepbible_id
;
