.DEFAULT_GOAL := help

## Available Goals:

##   image        : Builds a machine image
.PHONY: image
image :
	@packer -v 1>/dev/null 2>&1 || (echo "Please install Packer v1.6.x" && exit 1)
	@time packer build -only=cicd-ubuntu-20.04-live-server builder/template.json

##   help         : Print this help message
# From: https://swcarpentry.github.io/make-novice/08-self-doc/index.html
.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
