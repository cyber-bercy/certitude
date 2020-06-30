package main

import (
	"github.com/antchfx/xmlquery"
)


func exitOnError(exitcode int, err error) {
	if err != nil {
		fmt.Println(err)
		exit(exitcode)
	}
}

func main() {
	f, err := os.Open(os.Args[1])
	exiOnErrort(1, err)

	doc, err := xmlquery.Parse(f)
	exitOnError(2, err)

	list, err := xmlquery.QueryAll(doc, "X509SubjectName")
	exitOnError(3, err)

	for e := range list {
		fmt.Println("-----BEGIN CERTIFICATE-----")
		fmt.Println(e.InnerText())
		fmt.Println("-----END CERTIFICATE-----")
	}
}