package main

import (
	"bytes"
	"compress/gzip"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os"

	"github.com/vincent-petithory/dataurl"
)

type Config struct {
	Storage Storage `json:"storage"`
}
type Storage struct {
	Files []File `json:"files"`
}
type File struct {
	Contents    Contents `json:"contents"`
	Path        string `json:"path"`
}
type Contents struct {
	Compression string `json:"compression"`
	Source      string `json:"source"`
}

func main() {
	var config Config
	err := json.NewDecoder(os.Stdin).Decode(&config)
	if err != nil {
		log.Fatal(err)
	}
	for i, v := range config.Storage.Files {
		fmt.Println("file:", i, v.Path, v.Contents.Compression)
		dataUrl, err := dataurl.DecodeString(v.Contents.Source)
		if err != nil {
			log.Fatal(err)
		}
		data := bytes.NewBuffer(dataUrl.Data)
		if (v.Contents.Compression == "gzip") {
			decompressedData, err := gzip.NewReader(data)
			if err != nil {
				log.Fatal(err)
			}
			io.Copy(os.Stdout, decompressedData)
		} else {
			io.Copy(os.Stdout, data)
		}
		fmt.Println()
	}
}
