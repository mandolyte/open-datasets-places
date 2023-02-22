select * from sbps_has_bcv_rel
;

select * from sbps_has_bcv_rel 
where to_bcv_id not in 
(
    select bcv_id from bcv_tbl
)
;

select distinct book_id from bcv_tbl;

select count(*) from sbps_has_bcv_rel
where to_bcv_id glob '*e'
or to_bcv_id glob '*d' 
or to_bcv_id glob '*c'
or to_bcv_id glob '*b'
or to_bcv_id glob '*a'
;
