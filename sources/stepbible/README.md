# StepBible 

This folder contains the following:

- `properNames.tsv`: the raw data retrieved from StepBible Github Repo. It is a copy of the TIPNR data as of late February, 2023.
- `properNames.csv`: this file is converted in full from the TSV file.
- `convertToCsv.go`: the code that converts the file from TSV to CSV.

To convert:

```sh
$ go run convertToCsv.go -i properNames.tsv -o properNames.csv
```

The conversion to CSV was just to make sure that the TSV
was parseable. It has no other purpose.

The processing for extracting the place data from this dataset
is found in the `tables/sb_places_tbl` folder.