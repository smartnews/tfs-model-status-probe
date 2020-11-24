
.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "------------------------------------------------------------------"
	@echo " Makefile options"
	@echo "------------------------------------------------------------------"
	@echo " > make help   		# show this help info"
	@echo " > make build  		# local build for development testing"
	@echo " > make proto-lint  	# run linter on proto"
	@echo " > make proto  		# regenerate artifacts from proto"
	@echo " > make test   		# run all the go tests"
	@echo ""


# required: go get github.com/ckaznocha/protoc-gen-lint
.PHONY: proto-lint
proto-lint:
	@echo "Running linter on proto.  No output is good."
	cd ./proto/tfproto/ \
	&& protoc --lint_out=./ -I. *.proto

.PHONY: proto
proto:
	cd ./proto/tfproto/ \
	&& protoc --go_out=. --go_opt=plugins=grpc -I. *proto

build:
	GOBIN=$(PWD)/bin \
		  go install ./...

.PHONY: test
test:
	go vet ./...
	go test ./...

.PHONY: clean 
clean:
	rm -rf ./bin/

