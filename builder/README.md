This directory is currently unused. It will be used once we start deploying
GitLab on major clouds. For now, we avoid custom-built Vagrant boxes since
it's rather unreliable for that purpose or otherwise fraught with gotchas.

### Ubuntu builder references

* https://imagineer.in/blog/packer-build-for-ubuntu-20-04/
* https://gist.github.com/DVAlexHiggs/03cdbef887736f03dcfe6d1749c18669

### Troubleshooting

#### Installation Hangs

Try restarting the VirtualBox server:

    sudo /Library/Application\ Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh restart

VirtualBox is buggy. Maybe check out VMWare in the future.
