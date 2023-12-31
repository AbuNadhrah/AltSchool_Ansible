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
    Status_Code=$(curl -I -s -o/dev/null -w "%{http_code}" "$SlaveIP")

    if [ $Status_Code -eq 200 ]; then

        #switch user to altschool - as I've learned, switching to the user (altschool) is counter-productive as this creates a  new session and halts execution of subsequent code in this block
        #sudo su altschool

        #Then let's run the following SSH commands - generate private / public key; copy public key to slave

        #First, check if we have previously generated private/public key
        if ! [ -f /home/altschool/.ssh/id_rsa.pub ]; then
            sudo -u altschool ssh-keygen -t rsa -N "" -f /home/altschool/.ssh/id_rsa
        fi

        #now check is sshpass is installed
        if ! type "sshpass" > /dev/null; then
            sudo apt-get install sshpass
        fi

        sudo -u altschool sshpass -p "vagrant" ssh-copy-id -i /home/altschool/.ssh/id_rsa.pub vagrant@$SlaveIP
    else
        echo "Slave is not alive"
    fi

    #Copy the contents of /mnt/altschool directory from the Master node to slave
    sudo scp /mnt/alstschool vagrant@$SlaveIP:/mnt/altschool
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

