<p align="center">
  <img src="https://raw.githubusercontent.com/relaxdiego/cicd/main/logo.png">
</p>

Relaxdiego CI/CD auto-provisions and auto-configures a GitLab cluster for you.


## Quick Start

Try it with the cluster configuration directory (configdir for short) at
`examples/manual`. Read `examples/manual/README.md` for instructions on how
to get started.


## Development Guide


### Development Requirements

I have been developing this project using the following tools but you
should be able to swap out some of them (VMware Fusion) with a few
modifications.

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VMware Fusion](https://www.vmware.com/asean/products/fusion.html)
* [sshpass](https://gist.github.com/relaxdiego/f2e09f72e9a54b2262c6acfcd40f7b55)


#### Special Considerations for macOS

Make sure you install the GNU versions of sed and grep since the BSD versions
that come with macOS have different interfaces:

```
brew install gnu-sed grep
echo "export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH" >> ~/.bash_profile
echo "export PATH=/usr/local/opt/grep/libexec/gnubin:$PATH"" >> ~/.bash_profile
```

Also make sure that your python environment has the right certificates by
installing the [certifi](https://pypi.org/project/certifi/) package:

```
pip install certifi
```


### Instantiate a Local Cluster

To facilitate a faster development workflow, we can instantiate a
dev cluster locally using Vagrant.

```
make gitlab configdir=examples/vagrant-vmware
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
make cluster-implode configdir=examples/vagrant-vmware
```


### More Make Goals

To see more Make goals, run:

```
make help
```
