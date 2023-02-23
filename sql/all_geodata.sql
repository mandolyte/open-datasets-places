select id, friendly_id, 
json_extract(linked_data, '$.s3b25cf.id') as stepbible_id,
json_extract(linked_data, '$.s7cc8b2.id') as wikidata_id,
json_extract(linked_data, '$.s2428ed.id') as pleiades_id, 
json_extract(linked_data, '$.s2428ed.data_url') pleiades_url
from geocoding_json_tbl 
;
