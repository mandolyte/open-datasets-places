# open-datasets-places
Open Datasets for Places

# Goals and Purpose


# Sources

The sources for this dataset are described below.

## StepBible

The StepBible dataset is in Github at: 
https://github.com/STEPBible/STEPBible-Data

The places data is a subset of the "proper names" file [here](https://github.com/STEPBible/STEPBible-Data/blob/master/TIPNR%20-%20Translators%20Individualised%20Proper%20Names%20with%20all%20References%20-%20STEPBible.org%20CC%20BY.txt)

In this repo, find a copy retrieved in February 2023 at `./sources/stepbible/properNames.tsv`

A README file in that folder will have more details.


# Tables

Each table and perhaps its related tables are in the sub-folders of the "tables" folder. Each folder will have:

- A README with processing details
- Code to do any transformations needed against raw or existing data
- Table data in CSV format which is ready for importing



# Appendix A - Regexp support in SQLite3

Adding regex support to SQLite3:
https://stackoverflow.com/questions/5071601/how-do-i-use-regex-in-a-sqlite-query

# Appendix B - To Do

## Simplification

Some relationship tables are not needed. In particular, `sbps_has_bcv_rel`. 
See issue [here](https://github.com/mandolyte/open-datasets-places/issues/1).

## Latitude and Longitude

Lots of datasets have these - but reasonably differ in the number decimal digits included. So this idea is to do the following:

- Include a new column for each that is trucated (not rounded) to tenths place. In looking at the data this seems to work pretty well. Also make this new column a REAL data type!
- This means that the two views which currently have these shortened forms are not needed.



