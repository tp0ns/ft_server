# LAUNCH SERVICES

service mysql start

echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'user1'@'localhost' IDENTIFIED BY 'root';" | mysql -u root
echo "GRANT USAGE ON *.* TO 'user1'@'localhost' IDENTIFIED BY 'root';" | mysql -u root
echo "GRANT ALL privileges ON *.* TO 'user1'@localhost;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

service nginx restart
service mysql restart
service php7.3-fpm restart
/etc/init.d/php7.3-fpm start

bash