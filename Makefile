.DEFAULT_GOAL := help

##
## Available Goals:
##

##   cluster               : Instantiates a cluster defined in the path pointed to
##                           by the configdir argument. Example:
##
##                              make cluster configdir=/path/to/config/dir
##
##                           The path may be absolute or relative to the Makefile.
##                           If you want to configure your local cluster, try:
##
##                              make cluster configdir=examples/vagrant-vmware
##
##                           This will require Vagrant and VMware Desktop/Fusion
##                           on your machine. If you would rather use VirtualBox,
##                           feel free to modify the Vagrantfile in that directory
##                           or copy it to a new location and modify it there.
##
##                           Note that this repository does not have a hard dependency
##                           on Vagrant or any other provisioning tool. Instead,
##                           it just expects to find a few hooks under the hooks
##                           directory in your configdir. It hands off provisioning
##                           to those hooks which have free rein on what to use.
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
##                           To adjust the verbosity of the playbook, use the verbosity
##                           argument as follows:
##
##                               make gitlab configdir=/path/to/config/dir verbosity=v
##
##                           Add more v characters to verbosity as needed.
##
.PHONY: gitlab
gitlab : cluster
	@configdir=$(configdir) tags=${tags} verbosity=${verbosity} scripts/configure

##   vault-edits           : Edit the Ansible vault file in yourconfigdir. Example:
##
##                             make vault-edits configdir=/path/to/configdir
##
##                           If vault.yml does not exist in the configdir, this
##                           goal will automatically initialize it.
##
.PHONY: vault-edits
vault-edits :
	@configdir=${configdir} scripts/ensure-cluster-id
	@configdir=${configdir} scripts/ensure-vault-password-file
	@configdir=${configdir} scripts/ensure-vault-file
	@configdir=${configdir} scripts/edit-vault-file

# From: https://swcarpentry.github.io/make-novice/08-self-doc/index.html
##   help                  : Print this help message
##
.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
