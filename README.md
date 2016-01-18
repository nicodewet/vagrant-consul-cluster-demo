# vagrant-consul-cluster-demo

Create and run a 2 node Consul cluster using Vagrant.

* vagrant up
* vagrant ssh consul1
* sudo journalctl -u consul.service
* sudo systemctl status consul.service
* vagrant ssh consul2
* sudo systemctl -u consul.service

