# LAUNCH SERVICES

service nginx restart
service mysql restart
service php7.3-fpm restart
/etc/init.d/php7.3-fpm start

echo "CREATE USER 'root' IDENTIFIED BY 'localhost';" | mysql -u root
echo "CREATE DATABASE mytest;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON mytest.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root
mysql mytest -u root --password=  < mytest.sql

bash