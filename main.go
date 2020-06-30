package main

import (
	"fmt"
	"os"
	"github.com/antchfx/xmlquery"
)

var (
	// Version number
	Version	string

	// Build datetime 
	Build	string
)

func exitOnError(exitcode int, err error) {
	if err != nil {
		fmt.Println("Erreur : ", err)
		os.Exit(exitcode)
	}
}

func main() {
	f, err := os.Open(os.Args[1])
	exitOnError(1, err)

	doc, err := xmlquery.Parse(f)
	exitOnError(2, err)
	fmt.Println(doc)

	list := xmlquery.Find(doc, "//X509SubjectName")

	for _, e := range list {
		fmt.Println("-----BEGIN CERTIFICATE-----")
		fmt.Println(e.InnerText())
		fmt.Println("-----END CERTIFICATE-----")
	}
}