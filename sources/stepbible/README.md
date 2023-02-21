# StepBible 

This folder contains the following:

- `properNames.tsv`: the raw data retrieved from StepBible Github Repo. It is a copy of the TIPNR data as of lat February, 2023.
- `properNames.csv`: this file is converted in full from the TSV file.
- `convertToCsv.go`: the code that converts the file from TSV to CSV.

To convert:

```sh
$ go run convertToCsv.go -i properNames.tsv -o properNames.csv
```

