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

# To Do

These are captured in the issues.


# Appendix A - Regexp support in SQLite3

Adding regex support to SQLite3:
https://stackoverflow.com/questions/5071601/how-do-i-use-regex-in-a-sqlite-query

