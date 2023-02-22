package main

import (
	"encoding/csv"
	"flag"
	"fmt"
	"log"
	"os"
	"strings"
)

func main() {
	input := flag.String("i", "", "Input CSV filename")
	flag.Parse()

	// open output file for main place table
	var w *csv.Writer
	fo, foerr := os.Create("pleiades_tbl.csv")
	if foerr != nil {
		log.Fatal("os.Create() Error for main place file:" + foerr.Error())
	}
	defer fo.Close()
	w = csv.NewWriter(fo)

	// open input file
	var r *csv.Reader
	if *input == "" {
		usage("Missing input filename")
	} else {
		fi, fierr := os.Open(*input)
		if fierr != nil {
			log.Fatal("os.Open() Error:" + fierr.Error())
		}
		defer fi.Close()
		r = csv.NewReader(fi)
	}

	// ignore expectations of fields per row
	r.FieldsPerRecord = -1
	r.LazyQuotes = true
	r.Comment = '#'
	records, err := r.ReadAll()
	if err != nil {
		log.Fatal(err)
	}

	// read loop for CSV
	headers := []string{
		"authors", "description", "featureType", "geometry",
		"maxDate", "minDate", "path", "pid", "reprLat", "reprLong", "timePeriodsKeys",
		"lat", "long",
	}

	// write the header rows first
	herr := writeRow(w, headers)
	if herr != nil {
		log.Fatalf("writeRow() error on header row: \n%v\n", herr)
	}

	for row := 1; row < len(records); row++ {
		// main place data file
		var arow []string
		latitude := records[row][8]
		lat := ""
		longitude := records[row][9]
		long := ""

		// now make the shortened versions to the tenths of a degree
		latParts := strings.Split(latitude, ".")
		longParts := strings.Split(longitude, ".")
		if len(latParts) > 1 {
			lat = latParts[0] + "." + latParts[1][0:1]
		}
		if len(longParts) > 1 {
			long = longParts[0] + "." + longParts[1][0:1]
		}

		arow = append(arow, records[row]...)
		arow = append(arow, lat, long)

		werr := writeRow(w, arow)
		if werr != nil {
			log.Fatalf("writeRow() error on row %v: \n%v\n", row, werr)
		}

	}
	w.Flush()
}

func writeRow(w *csv.Writer, cells []string) error {
	err := w.Write(cells)
	if err != nil {
		return err
	}
	return nil
}

func usage(msg string) {
	fmt.Println(msg + "\n")
	fmt.Print("Usage: parseProperNames -i input.csv -o output.csv\n")
	flag.PrintDefaults()
	os.Exit(1)
}
