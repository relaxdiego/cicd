Example Cluster ConfigDir for Manually-Created Machines
=======================================================

Use this as a starting point for installing GitLab in a
cluster of machines that you've provisioned manually or
outside of this configdir's usual methods.

Copy this directory to another location and optionally
turn it into its own git repo.

Then run the following from this repo:

```
make vault-edits configdir=/path/to/new/configdir
```

The keys that you need to add to the vault file are the
jinja template variables in vars.yml that start with
"vault_"

Next, edit the vars.yml as you see fit. Although it should
be good for starters.

Finally, modify the hosts file so that it points to the
correct machines that you provisioned.

Then run:

```
make gitlab configdir=/path/to/new/configdir
```
