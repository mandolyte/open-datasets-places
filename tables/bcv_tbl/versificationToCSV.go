package main

import (
	"encoding/csv"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	fileName := "ufw.vrs"

	fileBytes, err := ioutil.ReadFile(fileName)

	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	old_new := map[string]string{
		"gen": "old",
		"exo": "old",
		"lev": "old",
		"num": "old",
		"deu": "old",
		"jos": "old",
		"jdg": "old",
		"rut": "old",
		"1sa": "old",
		"2sa": "old",
		"1ki": "old",
		"2ki": "old",
		"1ch": "old",
		"2ch": "old",
		"ezr": "old",
		"neh": "old",
		"est": "old",
		"job": "old",
		"psa": "old",
		"pro": "old",
		"ecc": "old",
		"sng": "old",
		"isa": "old",
		"jer": "old",
		"lam": "old",
		"ezk": "old",
		"dan": "old",
		"hos": "old",
		"jol": "old",
		"amo": "old",
		"oba": "old",
		"jon": "old",
		"mic": "old",
		"nam": "old",
		"hab": "old",
		"zep": "old",
		"hag": "old",
		"zec": "old",
		"mal": "old",
		"mat": "new",
		"mrk": "new",
		"luk": "new",
		"jhn": "new",
		"act": "new",
		"rom": "new",
		"1co": "new",
		"2co": "new",
		"gal": "new",
		"eph": "new",
		"php": "new",
		"col": "new",
		"1th": "new",
		"2th": "new",
		"1ti": "new",
		"2ti": "new",
		"tit": "new",
		"phm": "new",
		"heb": "new",
		"jas": "new",
		"1pe": "new",
		"2pe": "new",
		"1jn": "new",
		"2jn": "new",
		"3jn": "new",
		"jud": "new",
		"rev": "new",
	}

	// open output file for main place table
	var w *csv.Writer
	fo, foerr := os.Create("bcv_tbl.csv")
	if foerr != nil {
		log.Fatal("os.Create() Error for bcv_tbl:" + foerr.Error())
	}
	defer fo.Close()
	w = csv.NewWriter(fo)

	headers := []string{
		"bcv_id",
		"book_id",
		"old_or_new",
		"chapter",
		"verse",
	}

	// write the header rows first
	herr := writeRow(w, headers)
	if herr != nil {
		log.Fatalf("writeRow() error on header row: \n%v\n", herr)
	}

	bcvData := strings.Split(string(fileBytes), "\n")

	// fmt.Println(bcvData)
	for i := range bcvData {
		if strings.HasPrefix(bcvData[i], "#") {
			continue
		}
		// fmt.Printf("%v\n", bcvData[i])

		// split on space
		bookData := strings.Split(bcvData[i], " ")
		bcv_id := ""
		old_or_new := ""
		book_id := ""
		chapter := ""
		verse := ""
		for j := range bookData {
			if j == 0 {
				book_id = strings.ToLower(bookData[0])
				old_or_new = old_new[book_id]
				continue
			}
			ref := bookData[j]
			cv := strings.Split(ref, ":")
			chapter = cv[0]
			verse = cv[1]
			v, aerr := strconv.Atoi(verse)
			if aerr != nil {
				log.Fatalf("Failed to convert verse number integer: %v", verse)
			}
			for vv := 1; vv < v+1; vv++ {
				bcv_id = fmt.Sprintf("%v.%v.%v", book_id, chapter, vv)
				var row []string
				row = append(row, bcv_id, book_id, old_or_new, chapter, fmt.Sprintf("%v", vv))
				err := writeRow(w, row)
				if err != nil {
					log.Fatalf("writeRow() error on row: \n%v\n", err)
				}
			}

		}

		// done after Revelation
		if strings.HasPrefix(bcvData[i], "REV") {
			break
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
