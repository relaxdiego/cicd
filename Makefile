.DEFAULT_GOAL := help

## Available Goals:

##   box                   : Builds a Vagrant box for local development
.PHONY: box
box : .tmp/output/local-cluster.box

##   local-cluster         : Instantiates the local dev cluster for development purposes
.PHONY: local-cluster
local-cluster : box
	@cd local-cluster && vagrant up

##   local-cluster-implode : Destroys the local dev cluster
.PHONY: local-cluster-implode
local-cluster-implode :
	@cd local-cluster && vagrant destroy -f

##   help                  : Print this help message
# From: https://swcarpentry.github.io/make-novice/08-self-doc/index.html
.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<

.tmp/output/local-cluster.box : builder/* builder/ubuntu/subiquity/http/*
	@packer -v 1>/dev/null 2>&1 || (echo "Please install Packer v1.6.x" && exit 1)
	@PACKER_CACHE_DIR=.tmp/packer_cache time packer build -force -only=local-cluster builder/template.json
	@(vagrant box list | grep 'local-cluster') && vagrant box remove -f 'local-cluster' || true
