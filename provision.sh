#!/usr/bin/env bash

# This script is Fedora 22 onwards specific.

# Step 1 - Get the necessary utilities and install them.
echo Installing dependencies...
sudo dnf --best install -y unzip wget

# Step 2 - Get the Consul Zip file and extract it to Fedora packaging guidelines dir
echo "Fetching Consul..."
cd /tmp/
wget https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_linux_amd64.zip -O consul.zip


echo "[Binary] Installing Consul to /usr/bin/consul ..."
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul

# Step 3: Create the consul configuration dir and data dir in the Fedora packaging guidelines dirs
echo "[Config] Placing Consul configuration in /etc/consul"
sudo mkdir /etc/consul
sudo chmod a+w /etc/consul
sudo mkdir /var/consul
sudo chmod a+w /var/consul

# Step 4: Copy the server configuration
cp $1 /etc/consul/config.json

# Step 5: Copy systemd config
cp /vagrant/consul.service /etc/systemd/system/

# Step 6: Enable and start consul service
systemctl enable consul.service
systemctl daemon-reload
systemctl start consul.service


