This project will use [Vagrant](http://vagrantup.com) to install a complete [JSMESS](https://github.com/jsmess/jsmess/) development environment in a local [VirtualBox](http://virtualbox.org/) VM.

##VITALLY IMPORTANT NOTE:

This doesn't work yet. Still working on fixing it.

##Features

* Build and test JSMESS on your machine without spending hours finding, installing and tweaking dependencies! (Instead, type a couple of commands and then wait an hour.)
* Latest JSMESS code automatically pulled from git at provision time.
* The `bios/` and `games/` folders in your clone are linked to the same folders in the JSMESS install. Any files dropped into those folders automatically appear on the other side!

##Recent Changes

* Ripped out Puppet, using shell script instead
* Now using Ubuntu 14.04 (Trusty)

##Help!

As you can see, I'm still a long way from having a working VM.
Anything you can do to assist would be deeply appreciated.

##INSTALL

1. Install the latest Virtualbox from http://www.virtualbox.org/
2. Install vagrant from http://vagrantup.com/
3. Drop a bios ROM in `bios/` and a game in `games/`
4. build VM and provision:
```
$ vagrant up
```
5. Enjoy your JSMESS environment!
6. Realise that it hasn't fully installed because it's still not fully
functioning, so dive in and help me.

##RUN

Here are some common vagrant operations:

* SSH into your VM (jsmess is checked out in ~vagrant/src/jsmess):
```
$ vagrant ssh
``````
* Destroy VM and rebuild from scratch
```
$ vagrant destroy

$ vagrant up
```

##Troubleshooting

####Virtualbox emits `The guest additions on this VM do not match the installed version of VirtualBox`

I'm going to assume that, as the warning says, this is probably fine.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/yozlet/jsmess-vagrant/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
