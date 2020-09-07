# CI/CD Kit

This is an experimental project that I'm using to bootstrap a CI/CD
cluster. Currently, I'm building this project with zero automated
testing but I expect that it will have one in the future. The ultimate
goal is to have a self-bootstrapping CI/CD cluster. Whether that's even
possible, I have no idea yet. I am hopeful though.


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


### Instantiate a Local Cluster

To facilitate a faster development workflow, we will instantiate a
dev cluster locally using Vagrant.

```
make local-cluster
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
