.DEFAULT_GOAL := help

## Available Goals:

##   box          : Builds a Vagrant box for local development
.PHONY: box
box : .tmp/output/cicd-ubuntu-20.04.box

##   help         : Print this help message
# From: https://swcarpentry.github.io/make-novice/08-self-doc/index.html
.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<

.tmp/output/cicd-ubuntu-20.04.box : builder/* builder/ubuntu/subiquity/http/*
	@packer -v 1>/dev/null 2>&1 || (echo "Please install Packer v1.6.x" && exit 1)
	@PACKER_CACHE_DIR=.tmp/packer_cache time packer build -force builder/template.json
