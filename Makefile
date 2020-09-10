.DEFAULT_GOAL := help

## Available Goals:

##   cluster               : Instantiates a cluster defined in the path pointed to
##                           by the configdir argument. Example:
##
##                              make cluster configdir=/path/to/config/dir
##
##                           The path may be absolute or relative to the Makefile.
##                           If you want to configure your local cluster, there's a
##                           convenience goal that you can call instead: `make local-cluster`.
##
##                           Note that, unlike its local-cluster counterpart, this goal does
##                           not check if the cluster has already been instantiated or not since
##                           it has no way of knowing what tool will be used for the instantiation
##                           mechanism. Thus, that responsibility is delegated to
##                           ${configdir}/hooks/instantiate-cluster.
##
.PHONY: cluster
cluster :
	@configdir=${configdir} scripts/instantiate-cluster

##   cluster-implode       : Destroys the cluster defined in the path pointed to by the
##                           configdir argument. Example:
##
##                              make cluster-implode configdir=/path/to/config/dir
##
##                           The path may be absolute or relative to the Makefile.
##                           If you want to configure your local cluster, there's a
##                           convenience goal that you can call instead:
##                           `make local-cluster-implode`.
##
.PHONY: cluster-implode
cluster-implode :
	@configdir=${configdir} scripts/implode-cluster

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

##   local-box             : Build a Vagrant box using Packer
##
.PHONY: local-box
local-box : .tmp/output/local-cluster.box
.tmp/output/local-cluster.box : builder/template.json builder/ubuntu/subiquity/http/*
	@PACKER_CACHE_DIR=.tmp/packer_cache time packer build -force -only=local-cluster builder/template.json
	vagrant box remove -f local-cluster || true

##   local-cluster         : Instantiates a local cluster for development purposes
##
.PHONY: local-cluster
local-cluster : .make-flag-local-cluster-created .tmp/output/local-cluster.box
.make-flag-local-cluster-created :
	@configdir=local-cluster/ scripts/instantiate-cluster
	touch .make-flag-local-cluster-created

##   local-cluster-implode : Destroys the local cluster
##
.PHONY: local-cluster-implode
local-cluster-implode :
	@configdir=local-cluster/ scripts/implode-cluster
	rm -vf .make-flag-local-cluster-created

##   local-gitlab          : Configures the local cluster to run GitLab. Same as running
##                           `make gitlab configdir=./local-cluster`
##
.PHONY: local-gitlab
local-gitlab : local-cluster
	@configdir=./local-cluster scripts/configure

##   help                  : Print this help message
# From: https://swcarpentry.github.io/make-novice/08-self-doc/index.html
.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
