


# 687856 Bethlehem

sqlite> select * from pleiades_tbl where pid = '/places/687856';
Isaac, B., D. R. Talbert, T. Elliott, S. Gillies|1:500,000 scale representative point location digitized from the Barrington Atlas of the Greek and Roman World by the Digital Atlas of Roman and Medieval Civilizations project at Harvard University.|unknown|{"type": "Point", "coordinates": [35.202123, 31.712291]}|640|-30|/places/687856/darmc-location-18245|/places/687856|31.712291|35.202123|roman,late-antique
sqlite> 


sqlite> select reprLat,reprLong from pleiades_tbl where pid = '/places/687856';
31.712291|35.202123
sqlite> 


sqlite> select * from sb_places_tbl where unique_name like 'Bethlehem%';
Bethlehem@Gen.35.16|H1035G|||31.70536129174666|35.21026630105202|gen.35.16
Bethlehem@Jos.19.15|H1035H|||32.735379|35.189704|jos.19.15
sqlite> 

From above, locations are close:
- latitude: sb vs pleiades: 31.70536129174666 and 31.712291
- longitude: sb vs pleiades: 35.21026630105202 and 35.202123
