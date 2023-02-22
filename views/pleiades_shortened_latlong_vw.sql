CREATE view pleiades_shortened_latlong_vw as 
    select 
    authors ,
    description ,
    featureType ,
    geometry ,
    maxDate ,
    minDate ,
    path ,
    pid ,
    round( cast(reprLat as real) , 1) as lat,
    round( cast(reprLong as real) , 1) as long,
    timePeriodsKeys 
    from pleiades_tbl
;