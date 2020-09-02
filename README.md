# CI/CD Kit

Bootstraps a CI/CD cluster for you.


## Development Guide


### Build the Vagrant Box

To ensure that everything is in code, we start by locally building our
machine image using VirtualBox. We will then post process that image to
generate a Vagrant box which we will later use for developing the
configuration playbook.

```
make image
```
