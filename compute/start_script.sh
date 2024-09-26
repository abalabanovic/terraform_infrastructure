#!/bin/bash

#Debian based OS
sudo apt update
sudo apt install apache2 -y
sudo apt install php -y


echo "<?php echo 'Hostname: ' . gethostname(); ?>" | sudo tee /var/www/html/${target_file}
sudo rm /var/www/html/index.html