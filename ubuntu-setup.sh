clear
echo
echo -e "\e[92m+------------------------------------------------+"
echo -e "\e[92m| \e[39mLAMP INSTALLER (Apache2 - Mysql - PHP )\e[92m        |"
echo -e "\e[92m| \e[39mBy: Abdulrahman http://aia.sa\e[92m                  |"
echo -e "\e[92m+------------------------------------------------+\e[39m"
echo
if [ -z "$1" ]
then
    read -s -p "Enter Password: " MYSQL_NEW_ROOT_PASSWORD
else
    MYSQL_NEW_ROOT_PASSWORD="$1"
fi

echo -e "\e[1;31m Updating apt-get:  \e[0m"
sudo apt-get update -y

echo -e "\e[1;31m Installing Apache2:  \e[0m"
sudo apt-get install apache2 -y
sudo systemctl start apache2.service

echo -e "\e[1;31m Installing MYSQL :  \e[0m"
sudo apt-get install mysql-server -y

sudo apt-get install aptitude -y
#!/bin/bash
aptitude -y install expect -y

echo -e "\e[1;31m mysql_secure_installation:  \e[0m"

SECURE_MYSQL=$(expect -c "
set timeout 3
spawn mysql_secure_installation
expect \"Press y|Y for Yes, any other key for No:\"
send \"n\r\"
expect \"New password:\"
send \"$MYSQL_NEW_ROOT_PASSWORD\r\"
expect \"Re-enter new password:\"
send \"$MYSQL_NEW_ROOT_PASSWORD\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")
echo "$SECURE_MYSQL"
aptitude -y purge expect
sudo apt-get remove aptitude -y
sudo apt-get purge aptitude -y
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_NEW_ROOT_PASSWORD';FLUSH PRIVILEGES;"
echo -e "\e[1;31m Installing PHP and its plugins :  \e[0m"
sudo apt-get install php -y

sudo apt-get install -y php-{bcmath,bz2,intl,gd,mbstring,mysql,zip} && sudo apt-get install libapache2-mod-php  -y

sudo systemctl enable apache2.service
sudo systemctl enable mysql.service

systemctl restart apache2.service
