#!/bin/sh

# for below:
# https://pkg.go.dev/github.com/mandolyte/csv-utils@v0.0.0-20190221222755-b49f9e2184bd/splitcsv
splitcsv -c 1,6,7,8,12,13,15,16,17,19,22 \
    -i pleiades-locations.csv \
    -o pleiades.csv


