FROM	debian:buster
LABEL	maintainer="tpons@student.42.fr"
COPY 	/srcs/start.sh .
COPY	/srcs/nginx.conf /root/

#INSTALL AND UPDATE PACKAGES
RUN		apt-get update && apt-get -y upgrade
RUN		apt-get -y install wget nginx mariadb-server mariadb-client
RUN		apt-get -y install php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline \
		php-mbstring

# CONFIG NGINX
RUN		mkdir -p  /var/www/html
COPY	/srcs/index.html /var/www/html/
COPY	/srcs/nginx.conf /etc/nginx/sites-available/localhost
RUN		ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

# CONFIG mySQL
RUN		service mysql start
RUN		mysql --version

# CONFIG PHP
RUN		service php7.3-fpm start
RUN		mkdir -p var/www/phpmyadmin
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN		tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components=1 -C /var/www/phpmyadmin

CMD 	bash start.sh