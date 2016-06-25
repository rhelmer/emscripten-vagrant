This project will use http://vagrantup.com and http://puppetlabs.com to 
install a complete https://github.com/kripken/emscripten/ environment in a
local http://virtualbox.org/ VM.

---
INSTALL
---

1) Install the latest Virtualbox from http://www.virtualbox.org/ 

2) Install vagrant from http://vagrantup.com/

3) build VM and provision with puppet
```bash
$ vagrant up
```
4) Enjoy your Emscripten environment!

Here are some common vagrant operations:

SSH into your VM (emscripten is checked out in ~vagrant/src/emscripten):
```bash
$ vagrant ssh
```
Re-run puppet
```bash
$ vagrant provision
```
Reboot VM and re-run puppet
```bash
$ vagrant reload
bash
Destroy VM and rebuild from scratch
```bash
$ vagrant destroy 

$ vagrant up
```
