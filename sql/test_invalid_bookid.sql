select * from sbps_has_bcv_rel 
where to_bcv_id not in 
(
    select bcv_id from bcv_tbl
)
and to_bcv_id regexp '[0-9]$'

/*
Results:

sqlite> . read sql/test_invalid_bookid.sql
Tyre@Jos.19.29|eze.26.2
Tyre@Jos.19.29|eze.26.3
Tyre@Jos.19.29|eze.26.4
Tyre@Jos.19.29|eze.26.7
Tyre@Jos.19.29|eze.26.15
Tyre@Jos.19.29|eze.27.2
Tyre@Jos.19.29|eze.27.3
Tyre@Jos.19.29|eze.27.3
Tyre@Jos.19.29|eze.27.8
Tyre@Jos.19.29|eze.27.32
Tyre@Jos.19.29|eze.28.2
Tyre@Jos.19.29|eze.28.12
Tyre@Jos.19.29|eze.29.18
Tyre@Jos.19.29|eze.29.18
sqlite> 

*/