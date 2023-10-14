#!/bin/bash

# Update packages
sudo apt-get update

# Install Apache
sudo apt-get install -y apache2

# Install MySQL and set root password
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server

# Install PHP and related modules
sudo apt-get install -y php libapache2-mod-php php-mysql

# Restart Apache
sudo service apache2 restart
