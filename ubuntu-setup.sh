sudo apt-get update
sudo apt-get install apache2

sudo apt-get install mysql-server libapache2-mod-auth-mysql php5-mysql

sudo mysql_install_db

sudo /usr/bin/mysql_secure_installation

sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt

#cat /etc/apache2/mods-enabled/dir.conf <<END
#<IfModule mod_dir.c>
#
#          DirectoryIndex index.php index.html index.cgi index.pl index.php index.xhtml index.htm
#
#</IfModule>
#END

#cat /var/www/info.php <<END
#<?php
#phpinfo();
#?>
#END
sudo service apache2 restart
