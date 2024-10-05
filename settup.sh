#!/bin/bash

# Update the system
sudo yum update -y

# Install necessary dependencies
sudo yum install -y gcc make

# Download and extract 3proxy
cd /tmp
wget https://github.com/z3APA3A/3proxy/archive/refs/tags/0.9.4.tar.gz
tar -xzf 0.9.4.tar.gz
cd 3proxy-0.9.4

# Compile 3proxy
make -f Makefile.Linux

# Create directories for 3proxy
sudo mkdir -p /usr/local/3proxy/bin
sudo mkdir -p /usr/local/3proxy/logs
sudo mkdir -p /usr/local/3proxy/run

# Move the compiled binaries to the appropriate directory
sudo cp src/3proxy /usr/local/3proxy/bin/

# Copy the configuration file to the 3proxy directory
sudo cp /path/to/your/3proxy.cfg /usr/local/3proxy/

# Create a systemd service file for 3proxy
sudo bash -c 'cat <<EOF > /etc/systemd/system/3proxy.service
[Unit]
Description=3proxy Proxy Server
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/3proxy/bin/3proxy /usr/local/3proxy/3proxy.cfg
ExecReload=/bin/kill -HUP $MAINPID
PIDFile=/usr/local/3proxy/run/3proxy.pid
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd and enable 3proxy service
sudo systemctl daemon-reload
sudo systemctl enable 3proxy.service

# Start 3proxy service
sudo systemctl start 3proxy.service

# Check the status of 3proxy service
sudo systemctl status 3proxy.service
