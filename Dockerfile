FROM	debian:buster
LABEL	maintainer="tpons@student.42.fr"
COPY 	/srcs/start.sh .
#was . instead of /root/
COPY	/srcs/nginx.conf /root/
COPY	/srcs/config.inc.php /root/
COPY	/srcs/info.php /root/

#INSTALL AND UPDATE PACKAGES
RUN		apt-get update && apt-get -y upgrade
RUN		apt-get -y install wget nginx mariadb-server mariadb-client
RUN		apt -y install php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline \
		php-mbstring

# CONFIG NGINX
RUN		mkdir -p /var/www/html
COPY	/srcs/index.html /var/www/html/
COPY	/srcs/nginx.conf /etc/nginx/sites-available/localhost
RUN		ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

# CONFIG mySQL
RUN		service mysql start

# CONFIG WORDPRESS
RUN		mkdir -p /var/www/html/wordpress
RUN		wget https://wordpress.org/latest.tar.gz 
RUN		tar -zxvf latest.tar.gz --strip-components=1 -C /var/www/html/wordpress
RUN		chown -R www-data:www-data /var/www/html/wordpress
COPY	/srcs/wp-config.php /var/www/html/wordpress

# CONFIG SSL
COPY	/srcs/dhparam.pem /etc/nginx/
COPY	/srcs/nginx-selfsigned.crt /etc/ssl/crt/
COPY	/srcs/nginx-selfsigned.key /etc/ssl/private/
COPY	/srcs/self-signed.conf /etc/nginx/snippets

# CONFIG PHP
RUN		service php7.3-fpm start
RUN		mkdir -p var/www/html/phpmyadmin
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN		tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
COPY	/srcs/config.inc.php var/www/html/phpmyadmin
COPY	/srcs/info.php var/www/html/info.php


CMD 	bash start.sh