When running the build, you should be able to VNC to 127.0.0.1:5959 at some point

Also, depending on your ISP and, sometimes, the time of day, 20.04 installation
may take longer than necessary. In that case, disconnect your workstation from
the network so that the installer doesn't try to reach out to the network.

### Ubuntu builder references

* https://nickcharlton.net/posts/automating-ubuntu-2004-installs-with-packer.html
* https://imagineer.in/blog/packer-build-for-ubuntu-20-04/
* https://gist.github.com/DVAlexHiggs/03cdbef887736f03dcfe6d1749c18669

### Troubleshooting

#### Installation Hangs

Try restarting the VirtualBox server:

    sudo /Library/Application\ Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh restart

VirtualBox is buggy. Maybe check out VMWare in the future.
