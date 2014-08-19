# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.name = 'jsmess'
    v.memory = 3072
    v.cpus = 2
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 80, host: 8080

  # Yes, we're using a shell script. None of your fancy Punchible configuration
  # management tooling here! A shell script was good enough for my grandma,
  # and it's good enough for me!
  config.vm.provision "shell", path: "bootstrap.sh"

  # Your bios and games folders are shared into /home/ubuntu/
  config.vm.synced_folder "bios/", "/home/ubuntu/bios"
  config.vm.synced_folder "games/", "/home/ubuntu/games"
end
