# -*- mode: ruby -*-
# vi: set ft=ruby :


####
# Remember to run VirtualBox.exe and vagrant.exe as administrator!
####

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"
  # config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64/versions/20160122.0.0/providers/virtualbox.box"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  config.vm.hostname = "dev"

  # Use XShell to login localhost:2223
  # config.vm.network :forwarded_port, guest: 22, host: 2223, id: 'ssh'
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
  config.ssh.forward_x11 = true
  config.ssh.forward_agent = true

  # See: https://github.com/dotless-de/vagrant-vbguest
  # vagrant plugin uninstall ffi
  # vagrant plugin install ffi --plugin-version 1.9.8
  # See: https://github.com/mitchellh/vagrant/issues/5869#issuecomment-116161654
  # Run first: vagrant plugin install vagrant-vbguest
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.iso_path = "/backup/virtualbox/VBoxGuestAdditions_5.0.16.iso"
  else
    puts 'You\'d better to run `vagrant plugin install vagrant-vbguest` '
  end



  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080 ,  host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.111.111"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  # config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "/data", "/workspace"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:

  config.vm.provider "virtualbox" do |vb|

    vb.name = "Vagrant"
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # vb.linked_clone = true

    # Customize the amount of memory on the VM:
    vb.memory = "2400"
    vb.cpus = 1
  end

  # View the documentation for the provider you are using for more
  # information on available options.


  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.



  config.vm.provision "shell", inline: <<-SHELL
    echo Hello
  SHELL

  config.vm.provision "shell", path: "./init.sh"


=begin
  config.vm.provision :chef_solo do |chef|
    chef.install = false
    chef.cookbooks_path = "chef/cookbooks"
    chef.add_recipe "dev"
  end
=end




  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end


end
