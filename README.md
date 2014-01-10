This project will use [Vagrant](http://vagrantup.com) and [Puppet](http://puppetlabs.com) to install a complete [JSMESS](https://github.com/jsmess/jsmess/) development environment in a local [VirtualBox](http://virtualbox.org/) VM.

##FEATURES

* Build and test JSMESS on your machine without spending hours finding, installing and tweaking dependencies! (Instead, type a couple of commands and then wait an hour.)
* Latest JSMESS code automatically pulled from git at provision time.
* The `bios/` and `games/` folders in your clone are linked to the same folders in the JSMESS install. Any files dropped into those folders automatically appear on the other side!

##Recent Changes

* Auto-install Puppet modules as git subtrees
* Fix jsmess make not finding clang yet (which requires understanding this first)
* Map host port to jsmess's web server

##TODO (i.e. Why It Doesn't Entirely Work Yet)

If you can help with any of the below, please do!
* Compilation doesn't create JS map file at the end
* Test-served pages don't work
* Is there an easy way of providing vagrant boxes for both VirtualBox and VMware in the config, that'll Just Work?

##INSTALL

1. Install the latest Virtualbox from http://www.virtualbox.org/ 
2. Install vagrant from http://vagrantup.com/
3. build VM and provision with puppet
```
$ vagrant up
```
4. Enjoy your JSMESS environment!

##RUN

Here are some common vagrant operations:

* SSH into your VM (jsmess is checked out in ~vagrant/src/jsmess):
```
$ vagrant ssh
```
* Re-run puppet
```
$ vagrant provision
```
* Reboot VM and re-run puppet
```
$ vagrant reload
```
* Destroy VM and rebuild from scratch
```
$ vagrant destroy 

$ vagrant up
```

##Troubleshooting

####Puppet emits `Could not retrieve fact fqdn` warning

Don't worry about this one; it's because we're running Puppet in standalone mode on a virtualised box that has no hostname. [Further explanation here.](https://github.com/puphpet/puphpet/issues/47)

####Virtualbox emits `The guest additions on this VM do not match the installed version of VirtualBox`

I'm going to assume that, as the warning says, this is probably fine.





[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/yozlet/jsmess-vagrant/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

