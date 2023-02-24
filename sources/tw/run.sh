#!/bin/sh

rm loader.sql
for i in kt names other
do
    echo Generating inserts for $i
    cd ./bible/$i 
    sh ../../load.sh $i >> ../../loader.sql
    cd -
done

# now all the inserts statements are done
# load into database

echo "Run the database imports"
echo NOTE!! cannot indent the sql commands
sqlite3 ../../places.db <<EoF
.echo on
drop table if exists tw_tbl;

CREATE TABLE tw_tbl(category TEXT, name TEXT, file BLOB);
.read loader.sql
select count(*) from tw_tbl;

.exit
EoF


