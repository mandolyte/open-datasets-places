# twl processing

Run the command below, which does:
- concatenates all the TSV files
- add a new column at the end of each to contain the BCV of each in the format `gen.1.1`
- writes out a new CSV file of all the data (`twl.csv`)

```sh
go run catTsvToCsv.go
```
