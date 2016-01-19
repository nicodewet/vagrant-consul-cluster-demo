# vagrant-consul-cluster-demo

Create and run a 2 node Consul cluster using Vagrant.

* vagrant up
* vagrant ssh consul1
* sudo journalctl -u consul.service
* sudo systemctl status consul.service
* vagrant ssh consul2
* sudo systemctl -u consul.service

Some basic test cases from your local.

DNS interface.

Let's look for an external search service that we hypothetically depend on but which we have not yet added to consul.

* dig @172.20.20.10 -p 8600 search.service.consul. 
* dig @172.20.20.20 -p 8600 search.service.consul.

	Nicos-Air:vagrant-consul-cluster-demo nico$ dig @172.20.20.20 -p 8600 search.service.consul.
	
	; <<>> DiG 9.8.3-P1 <<>> @172.20.20.20 -p 8600 search.service.consul.
	; (1 server found)
	;; global options: +cmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 49383
	;; flags: qr aa rd; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 0
	;; WARNING: recursion requested but not available
	
	;; QUESTION SECTION:
	;search.service.consul.		IN	A
	
	;; AUTHORITY SECTION:
	consul.			0	IN	SOA	ns.consul. postmaster.consul. 1453193803 3600 600 86400 0
	
	;; Query time: 6 msec
	;; SERVER: 172.20.20.20#8600(172.20.20.20)
	;; WHEN: Tue Jan 19 22:15:03 2016
	;; MSG SIZE  rcvd: 107

Now lets add the external service to consul.

	curl -X PUT -d '{"Datacenter": "dc1", "Node": "google", "Address": "www.google.com", "Service": {"Service": "search", "Port": 80}}' http://172.20.20.20:8500/v1/catalog/register
	curl -X PUT -d '{"Datacenter": "dc1", "Node": "bing", "Address": "www.bing.com", "Service": {"Service": "search", "Port": 80}}' http://172.20.20.20:8500/v1/catalog/register

If we now use query consul via DNS, we get two results.

	Nicos-MacBook-Air:vagrant-consul-cluster-demo nico$ dig @172.20.20.10 -p 8600 search.service.consul.
	
	; <<>> DiG 9.8.3-P1 <<>> @172.20.20.10 -p 8600 search.service.consul.
	; (1 server found)
	;; global options: +cmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 59334
	;; flags: qr aa rd; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 0
	;; WARNING: recursion requested but not available
	
	;; QUESTION SECTION:
	;search.service.consul.		IN	A
	
	;; ANSWER SECTION:
	search.service.consul.	0	IN	CNAME	www.google.com.
	search.service.consul.	0	IN	CNAME	www.bing.com.
	
	;; Query time: 2 msec
	;; SERVER: 172.20.20.10#8600(172.20.20.10)
	;; WHEN: Tue Jan 19 22:27:20 2016
	;; MSG SIZE  rcvd: 135

Given that high level service health checking is a part of consul, this is something we'll get onto next.






