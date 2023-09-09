#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)." 
   exit 1
fi

# Stop Nginx and Apache if they are running
systemctl stop nginx
systemctl stop apache2

# Disable Nginx and Apache from starting at boot
systemctl disable nginx
systemctl disable apache2

# Remove Nginx and Apache
apt-get purge nginx apache2 -y

# Remove configuration files
rm -rf /etc/nginx /etc/apache2

# Remove default site files (adjust paths as needed)
rm -rf /var/www/html/*
rm -rf /var/www/html/.htaccess

# Reload systemd to apply changes
systemctl daemon-reload

echo "Nginx and Apache have been completely removed, and default site files have been deleted."
