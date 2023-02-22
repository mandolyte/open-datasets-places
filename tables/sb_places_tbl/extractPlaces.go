package main

import (
	"encoding/csv"
	"flag"
	"fmt"
	"log"
	"os"
	"strings"
)

/*
Here is the documentation on the "columns" for place data:
	UniqueName=uStrong	OpenBible name=Near	Founder	People living there	GoogleMap URL	Palopenmaps URL	>Geographical area
	- Significance	UniqueName	dStrong«eStrong=Heb/Grk	ESV name (and KJV, NIV)	STEPBible link for first Refs                 /	All Refs

There is one line for first row, which is "key" data
Then one or more rows for the second row, which refers to
the various kinds of "sigificances".

Most of these appear to start with a dash and the most common
is "- Named"

*/

func main() {
	input := flag.String("i", "", "Input CSV filename")
	flag.Parse()

	// open output file for main place table
	var w *csv.Writer
	fo, foerr := os.Create("sb_places_tbl.csv")
	if foerr != nil {
		log.Fatal("os.Create() Error for main place file:" + foerr.Error())
	}
	defer fo.Close()
	w = csv.NewWriter(fo)

	// open output file for significance table
	var s *csv.Writer
	sfo, sfoerr := os.Create("sbp_significance_tbl.csv")
	if sfoerr != nil {
		log.Fatal("os.Create() Error for significance file:" + sfoerr.Error())
	}
	defer sfo.Close()
	s = csv.NewWriter(sfo)

	// open output file for the sbps_has_bcv_rel table
	var sb *csv.Writer
	sbfo, sbfoerr := os.Create("sbps_has_bcv_rel.csv")
	if sbfoerr != nil {
		log.Fatal("os.Create() Error for significance file:" + sbfoerr.Error())
	}
	defer sbfo.Close()
	sb = csv.NewWriter(sbfo)

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
	r.Comma = '\t'
	r.Comment = '#'
	records, err := r.ReadAll()
	if err != nil {
		log.Fatal(err)
	}

	// read loop for CSV
	//	UniqueName=uStrong	OpenBible name=Near	Founder	People living there	GoogleMap URL	Palopenmaps URL	>Geographical area

	headers := []string{
		"unique_name",
		"strongs",
		"founder",
		"people_group",
		"latitude",
		"lat",
		"longitude",
		"long",
		"bcv_id",
	}

	sheaders := []string{
		"unique_name",
		"qualifer",
		"significance",
		"estrong",
		"dstrong",
		"original",
		"esv_name",
	}

	sbheaders := []string{
		"from_unique_name",
		"to_bcv_id",
	}

	// write the header rows first
	herr := writeRow(w, headers)
	if herr != nil {
		log.Fatalf("writeRow() error on header row: \n%v\n", herr)
	}
	serr := writeRow(s, sheaders)
	if serr != nil {
		log.Fatalf("writeRow() error on significance header row: \n%v\n", serr)
	}
	sberr := writeRow(sb, sbheaders)
	if sberr != nil {
		log.Fatalf("writeRow() error on significance header row: \n%v\n", sberr)
	}

	const dataStart = 10330
	const placeMarker = "$========== PLACE"
	for row := 0; row < len(records); row++ {

		if records[row][0] == placeMarker && row > dataStart {
			// place data doesn't begin until row 10326
			// but there is intro data near the beginning
			// that we need to overlook
		} else {
			continue
		}

		// main place data file
		var arow []string
		// fill up the row
		// split strongs from unique name
		x := strings.Split(records[row+1][0], "=")
		unique_name := x[0]
		log.Printf("Working on unique_name: %v", unique_name)
		strongs := x[1]
		founder := records[row+1][2]
		people_group := records[row+1][3]
		latitude := ""
		lat := ""
		longitude := ""
		long := ""
		// transform the google map url to extract the long/lat
		// example: https://www.google.com/maps/@33.545097,36.224661,14z
		_lat_long := strings.ReplaceAll(records[row+1][4], " ", "") // remove extra spaces
		__lat_long := strings.Split(_lat_long, "@")
		if len(__lat_long) > 1 {
			___lat_long := strings.Split(__lat_long[1], ",") // long, lat, zoom
			latitude = ___lat_long[0]
			longitude = ___lat_long[1]

			// now make the shortened versions to the tenths of a degree
			latParts := strings.Split(latitude, ".")
			longParts := strings.Split(longitude, ".")
			if len(latParts) > 1 {
				lat = latParts[0] + "." + latParts[1][0:1]
			}
			if len(longParts) > 1 {
				long = longParts[0] + "." + longParts[1][0:1]
			}
		}
		// first location of bcv, which is embedded in the unqiue_name
		_bcv := strings.Split(unique_name, "@")
		bcv_id := strings.ToLower(_bcv[1])
		// data quality: replace "eze" with "ezk"
		bcv_id = strings.Replace(bcv_id, "eze", "ezk", 1)

		arow = append(arow,
			unique_name,
			strongs,
			founder,
			people_group,
			latitude,
			lat,
			longitude,
			long,
			bcv_id,
		)
		werr := writeRow(w, arow)
		if werr != nil {
			log.Fatalf("writeRow() error on row %v: \n%v\n", row, werr)
		}

		// significance file
		j := row + 2 // beginning after the main place data row
		for {
			if j == len(records) {
				break
			}
			cella := strings.TrimSpace(records[j][0])
			// log.Printf("cella/%v/", cella)
			if cella == placeMarker {
				break
			}
			// at the end of the place data are empty rows
			if cella == "" {
				j++
				continue
			}
			// if it is a note
			if strings.HasPrefix(cella, "NOTES") {
				j++
				continue
			}
			// if the string is really long it is the note content
			if len(cella) > 21 {
				j++
				continue
			}
			if strings.HasPrefix(cella, "#==") {
				break
			}
			if strings.HasPrefix(cella, "$==") {
				break
			}
			// data misplace?
			if strings.HasPrefix(cella, "Rahab@Jos.2.1=H7343") {
				break
			}
			// columns for significance data:
			// 	- Significance,UniqueName,dStrong«eStrong=Heb/Grk,
			// ESV name (and KJV, NIV),STEPBible link for first,Refs
			// Will skip the step bible link
			// "unique_name",
			// "qualifer",
			// "significance",
			// "estrong",
			// "dstrong",
			// "original",
			// "esv_name",

			unique_name = ""
			qualifier := ""
			significance := ""
			dstrong := ""
			estrong := ""
			original := ""
			esv_name := ""

			for c, v := range records[j] {
				if c == 0 {
					significance = v
				}
				if c == 1 {
					// the unique name may have a qualifier.
					// if so, it will follow this pattern: "west|Arabia@2Sa.23.35"
					x := strings.Split(v, "|")
					if len(x) > 1 {
						qualifier = x[0]
						unique_name = x[1]
					} else {
						unique_name = v
					}
				}
				if c == 2 {
					// example: ,H0062«H0062=אָבֵל בֵּית מַעֲכָה,
					strongsData := strings.FieldsFunc(v, func(r rune) bool {
						return r == '«' || r == '='
					})
					dstrong = strongsData[0]
					if len(strongsData) == 3 {
						estrong = strongsData[1]
						original = strongsData[2]
					} else {
						// when only one strongs number is present
						estrong = ""
						original = strongsData[1]
					}
				}
				if c == 3 {
					esv_name = v
				}
				if c == 5 {
					refs := strings.Split(v, ";")
					for _, vref := range refs {
						var sbrow []string
						_vref := strings.Trim(vref, " ")
						if _vref == "" {
							continue
						}
						_vref = strings.ToLower(_vref)
						sbrow = append(sbrow, unique_name, _vref)
						sberr := writeRow(sb, sbrow)
						if sberr != nil {
							log.Fatalf("writeRow() error on unique name %v with refs %v", unique_name, v)
						}
					}
				}
			}
			var srow []string
			srow = append(srow,
				unique_name,  // unique name
				qualifier,    // qualifer
				significance, // significance
				dstrong,      // disambiguated strongs
				estrong,      // electronic strongs
				original,     // orginal language word(s)
				esv_name,     // esv name
			)
			serr := writeRow(s, srow)
			if serr != nil {
				log.Fatalf("writeRow() error on row %v: \n%v\n", srow, serr)
			}
			j++
		}
	}
	w.Flush()
	s.Flush()
	sb.Flush()
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
