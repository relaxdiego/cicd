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
	@configdir=$(configdir) tags=${tags} verbose=${verbose} scripts/configure

##   local-cluster         : Instantiates a local cluster for development purposes
##
.PHONY: local-cluster
local-cluster : .make-flag-local-cluster-created
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
	make gitlab configdir=./local-cluster tags=${tags}

##   local-vault-edits     : Edit the Ansible vault file of the local cluster
##                           Same as running `make vault-edits configdir=./local-cluster`
##
.PHONY: local-vault-edits
local-vault-edits :
	make vault-edits configdir=local-cluster

##   vault-edits           : Edit the Ansible vault file of $configdir. Example:
##
##                             make vault-edits configdir=/path/to/configdir
##
.PHONY: vault-edits
vault-edits :
	@configdir=${configdir} scripts/ensure-cluster-id
	@configdir=${configdir} scripts/ensure-vault-password-file
	@configdir=${configdir} scripts/ensure-vault-file
	@configdir=${configdir} scripts/edit-vault-file

##   help                  : Print this help message
# From: https://swcarpentry.github.io/make-novice/08-self-doc/index.html
.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
