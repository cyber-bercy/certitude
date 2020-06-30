
APP		:= certitude
BIN		= .
VERSION	:= `cat VERSION`
BUILD	:= `date +%y%m%d.%H%M%S`

LDFLAGS	= -ldflags "-X github.com/cyber-bercy/certitude/main.Version=$(VERSION) -X github.com/cyber-bercy/certitude/main.Build=$(BUILD)"
MAIN	= main.go

# pour les commandes `make` sans argument
default: help

version: ## Affiche la version selon le code source
	@echo $(VERSION)

git-version: ## Affiche la version selon git
	@git describe --always --long --tags --dirty

git-release: ## Crée un Tag/Release dans l'historique de git
	git tag -a $(VERSION) -m "Release" || true
	git push origin $(VERSION)

deps: ## Installe les librairies Golang requises par le projet
	go get -v ./...	

build: ## Compile le projet
	go build ${LDFLAGS} -v -o ${BIN}/${APP} ${MAIN}


clean: ## Néttoie cache et produit final
	go clean

test: ## Lance les tests, sauf qui sont long
	# prenant exemple de https://github.com/Ullaakut/go-advices#testing
	go test -v ./...

benchmark: ## Lance les éventuels Benchmark
	go test -bench=./...

list-modules: ## liste les versions compilées
	go version -m ${BIN}/${APP}

list-upgrades: ## Liste les modules pas à jour
	go list -u -m all
	
.PHONY: version git-version git-release deps build clean test help list-modules list-upgrades

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'