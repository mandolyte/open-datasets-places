# open-datasets-places
Open Datasets for Places

# Goals and Purpose

To evaluate the value of open data and research ways to link them together.

This repo was created during the OCE Hackathon in Feb 2023. And my report 
at the end is [here](https://github.com/mandolyte/uw-journal/blob/main/research/Open%20Datasets/Pitch%20out%20for%20Friday%2C%20Feb%2024%2C%202023.md)

Instead of building an app that showed how the data 
could be linked, I built a database (Sqlite3) which 
was used to link the datasets. The value of doing it
this way clearly showed how the data had to be 
transformed in order to link with other datasets.

# Sources

The sources for this dataset are described below.

## StepBible

The StepBible dataset is in Github at: 
https://github.com/STEPBible/STEPBible-Data

The places data is a subset of the "proper names" file [here](https://github.com/STEPBible/STEPBible-Data/blob/master/TIPNR%20-%20Translators%20Individualised%20Proper%20Names%20with%20all%20References%20-%20STEPBible.org%20CC%20BY.txt)

In this repo, find a copy retrieved in February 2023 at `./sources/stepbible/properNames.tsv`

A README file in that folder will have more details.

## Pleiades

There are many downloads available from the Pleiades web site [here](https://pleiades.stoa.org/downloads).

I used this one, retrieved on Feb 20, 2023:
https://atlantides.org/downloads/pleiades/dumps/pleiades-locations-latest.csv.gz

The README in that folder will have details on how the data was processed.

## Geocoding

This data is from https://github.com/openbibleinfo/Bible-Geocoding-Data.

See the README for how the data was processed.

## unfoldingWord's Translation Word articles and Word Lists.

Each of these folders has a README with details on how the data was
processed and made linkable.

# Tables

Each table and perhaps its related tables are in the sub-folders of the "tables" folder. Each folder will have:

- A README with processing details
- Code to do any transformations needed against raw or existing data
- Table data in CSV format which is ready for importing

# SQL 

This folder has a small number of SQL statements used during
the processing of the data.

More SQL can be found in:
- sqlstudio.sql: record of queries used in the SqlStudio application
- Hackathon-2023.sql: SQL used for the demos in the report-out.

# Views

This folder contains the views created during the Hackathon to better
understand the data. But in the end, the data did not require any.
But I elected to keep them anyway.

# To Do

These are captured in the issues.


# Appendix A - Regexp support in SQLite3

Adding regex support to SQLite3:
https://stackoverflow.com/questions/5071601/how-do-i-use-regex-in-a-sqlite-query

