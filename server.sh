#!/bin/bash

function servicechecker {
	echo "Checking $1 state"
if [ "$(dpkg -l | grep $1)" = "" ]
	then
	if [ "$(sudo netstat -laputen | grep $2)" = "" ]
		then
		echo "apache not installed. Installing $1"
		sudo apt-get install $1
	else 
		echo "conflict in :$2, installation aborted"
	fi
else
	echo "$1 is already installed"
fi
	
	
}

echo "welcome to $0"

servicechecker apache2 80
servicechecker mysql-server 3306

echo "Checking php5 state"
if [ "$(dpkg -l | grep mysql-server)" = "" ]
	then
	echo "php5 not installed. Installing apache"
	sudo apt-get install php5
else
	echo "php5 is already installed"
fi


sudo service apache2 restart
sudo service mysql restart

sudo mkdir /var/www/html/
sudo mkdir /var/www/html/test

sudo rm test.php
sudo touch test.php
sudo chown test.php 
sudo cat << 'EOF' >test.php 
<html> <? phpinfo(); ?> </html>
EOF









