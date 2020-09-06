.DEFAULT_GOAL := help

## Available Goals:

##   box                   : Builds a Vagrant box for local development
##
.PHONY: box
box : .tmp/output/local-cluster.box

##   gitlab                : Configures a cluster defined by the configdir argument.
##                           Example:
##
##                               make gitlab configdir=/path/to/config/dir
##
##                           The path may be absolute or relative to the Makefile.
##                           If you want to configure your local cluster, there's a
##                           convenience goal that you can call instead: `make local-gitlab`
##
.PHONY: gitlab
gitlab :
	@configdir=$(configdir) scripts/configure

##   local-cluster         : Instantiates the local dev cluster for development purposes
##
.PHONY: local-cluster
local-cluster : box
	@cd local-cluster && vagrant up

##   local-cluster-implode : Destroys the local dev cluster
##
.PHONY: local-cluster-implode
local-cluster-implode :
	@cd local-cluster && vagrant destroy -f

##   local-gitlab          : Configures local-cluster to run GitLab. Same as running
##                           `make gitlab configdir=./local-cluster`
##
.PHONY: local-gitlab
local-gitlab :
	@configdir=./local-cluster scripts/configure

##   help                  : Print this help message
# From: https://swcarpentry.github.io/make-novice/08-self-doc/index.html
.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<

.tmp/output/local-cluster.box : builder/* builder/ubuntu/subiquity/http/*
	@packer -v 1>/dev/null 2>&1 || (echo "Please install Packer v1.6.x" && exit 1)
	@PACKER_CACHE_DIR=.tmp/packer_cache time packer build -force -only=local-cluster builder/template.json
	@(vagrant box list | grep 'local-cluster') && vagrant box remove -f 'local-cluster' || true
