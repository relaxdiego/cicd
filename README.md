# CI/CD Kit

Bootstraps a CI/CD cluster for you.


## Development Guide


### Development Requirements

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [Packer](https://www.packer.io/downloads.html)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [sshpass](https://gist.github.com/relaxdiego/f2e09f72e9a54b2262c6acfcd40f7b55)

#### Special Case for macOS

Make sure you install the GNU versions of sed and grep since the BSD versions
that come with macOS have different interfaces:

```
brew install gnu-sed grep
echo "export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH" >> ~/.bash_profile
echo "export PATH=/usr/local/opt/grep/libexec/gnubin:$PATH"" >> ~/.bash_profile
```


### Build the Vagrant Box

To ensure that everything is in code, we start by locally building our
machine image using VirtualBox. We will then post process that image to
generate a Vagrant box which we will later use when developing our
configuration scripts.

```
make box
```


### Instantiate a Local Cluster

To facilitate a faster development workflow, we will instantiate a
dev cluster locally using Vagrant.

```
make local-cluster
```
