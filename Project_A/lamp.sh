#!/bin/bash

###User Management segment
#First, check which VM is executing the script by
# Check the hostname of the VM
if [ "$(hostname)" = "master" ]; then
    # Create a user named altschool only on the master VM
    sudo useradd -m altschool
    # Set a password for the altschool user
    echo "altschool:password" | sudo chpasswd
    # Give the altschool user root privileges
    sudo usermod -aG sudo altschool

    #Enable SSH key-based authentication:
    #First check if the slave is alive
    SlaveIP="192.168.56.104"
    if curl -I "$SlaveIP"; then

        #switch user to altschool
        sudo su altschool

        #Then let's run the following SSH commands - generate private / public key; copy public key to slave
        sudo -u ssh-keygen -t rsa -N "" -f /home/altschool/.ssh/id_rsa
        sudo sshpass -p "vagrant" ssh-copy-id -i /home/altschool/.ssh/id_rsa.pub vagrant@$SlaveIP
    else
        echo "Slave is not alive"
    fi
fi

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

