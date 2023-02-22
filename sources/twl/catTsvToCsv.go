package main

import (
	"encoding/csv"
	"io/ioutil"
	"log"
	"os"
	"strings"
)

func main() {
	/*
		First, open the directory and get all the TSV files
	*/
	finfo, rderr := ioutil.ReadDir(".")
	if rderr != nil {
		log.Fatal("Error:", rderr)
	}
	dirlist := make([]string, len(finfo))

	/*
		Read TSV filenames
	*/
	var i int
	for _, fi := range finfo {
		dirlist[i] = fi.Name()
		i++
	}

	/*
		Process each file in the array
	*/
	var allrows [][]string
	firstFile := true
	for i, fname := range dirlist {
		if !strings.HasSuffix(fname, ".tsv") {
			continue
		}
		x := strings.Split(fname, ".")
		y := strings.Split(x[0], "_")
		bookid := strings.ToLower(y[1])
		log.Printf("Working on Book %v #%v with TSV:%s", bookid, i, fname)

		// open the TSV file
		f, ferr := os.Open(fname)
		if ferr != nil {
			log.Fatal("os.Open() Error:" + ferr.Error())
		}
		r := csv.NewReader(f)
		// ignore expectations of fields per row
		r.FieldsPerRecord = -1
		r.Comma = '\t'
		// read the file
		rows, rerr := r.ReadAll()
		if rerr != nil {
			log.Fatal("r.ReadAll() Error:" + rerr.Error())
		}
		for j := 0; j < len(rows); j++ {
			if firstFile && j == 0 {
				// get the header row
				rows[j] = append(rows[j], "book_id", "bcv_id")
				allrows = append(allrows, rows[j])
				firstFile = false
			} else if j == 0 {
				// skip all other header rows in other files
				continue
			} else {
				// form the bcv_id value
				ref := rows[j][0]
				ref = strings.Replace(ref, ":", ".", -1)
				bcv_id := bookid + "." + ref
				rows[j] = append(rows[j], bookid, bcv_id)
				allrows = append(allrows, rows[j])
			}
		}

		f.Close()
	}

	// write out the chronologically concatenated CSV
	w, werr := os.Create("twl.csv")
	if werr != nil {
		log.Fatal("os.Create() Error:" + werr.Error())
	}

	csvw := csv.NewWriter(w)
	csvw.WriteAll(allrows)
	w.Close()

	log.Print("All Done!\n")
}
