#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)." 
   exit 1
fi

# Stop Nginx and Apache if they are running
systemctl stop nginx
systemctl stop httpd

# Disable Nginx and Apache from starting at boot
systemctl disable nginx
systemctl disable httpd

# Remove Nginx and Apache
yum remove nginx httpd -y

# Remove configuration files
rm -rf /etc/nginx /etc/httpd

# Reload systemd to apply changes
systemctl daemon-reload

echo "Nginx and Apache have been completely removed, and default site files have been deleted."
