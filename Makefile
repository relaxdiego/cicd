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
gitlab : cluster
	@configdir=$(configdir) tags=${tags} verbose=${verbose} scripts/configure

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
