# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box = "fedora/23-cloud-base"

  config.vm.define "consul1" do |consul1|
    config.vm.provision "shell" do |s|
        s.path = "provision.sh"
        s.args   = ["/vagrant/consul1-config.json"]
    end
    consul1.vm.hostname = "consul1"
    consul1.vm.network "private_network", ip: "172.20.20.10"
  end

  config.vm.define "consul2" do |consul2|
    config.vm.provision "shell" do |s|
        s.path = "provision.sh"
        s.args   = ["/vagrant/consul2-config.json"]
    end
    consul2.vm.hostname = "consul2"
    consul2.vm.network "private_network", ip: "172.20.20.20"
  end
end
