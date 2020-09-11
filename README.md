# CI/CD Kit

This is an experimental project that I'm using to bootstrap a CI/CD
cluster. Currently, I'm building this project with zero automated
testing but I expect that it will have one in the future. The ultimate
goal is to have a self-bootstrapping CI/CD cluster. Whether that's even
possible, I have no idea yet. I am hopeful though.


## Quick Start

NOTE: This part is not well documented yet since I'm still working on
most of the logic so you'll have to read the code to get a better
understanding of how it works.

```
make gitlab configdir=/path/to/config/dir
```

Basically, what I intend to do with the above is that you should be able
to define your cluster's config in a separate, non-public repo which
you can feed to this project so that it can configure your GitLab cluster.

For more Make goals, run `make help`


## Development Guide


### Development Requirements

I have been developing this project using the following tools but you
should be able to swap out some of them (VMware Fusion) with a few
modifications.

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [Packer](https://www.packer.io/downloads.html)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VMware Fusion](https://www.vmware.com/asean/products/fusion.html)
* [sshpass](https://gist.github.com/relaxdiego/f2e09f72e9a54b2262c6acfcd40f7b55)

#### Special Case for macOS

Make sure you install the GNU versions of sed and grep since the BSD versions
that come with macOS have different interfaces:

```
brew install gnu-sed grep
echo "export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH" >> ~/.bash_profile
echo "export PATH=/usr/local/opt/grep/libexec/gnubin:$PATH"" >> ~/.bash_profile
```


### Instantiate a Local Cluster

To facilitate a faster development workflow, we will instantiate a
dev cluster locally using Vagrant.

```
make local-gitlab
```

Once provisioning has completed, you should now be able to ssh to your
dev cluster's machines:

```
ssh gitlab
ssh runner
```

You should also be able to browse to your dev GitLab instance:

```
curl -L http://gitlab.localdev
```


### Clean Up the Local Cluster

When you're done and want to remove the local cluster, run:

```
make local-cluster-implode
```


### More Make Goals

To see more Make goals, run:

```
make help
```
