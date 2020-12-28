FROM debian:buster
#we want to have our work directory
WORKDIR /var/www/html

#installig pacages we need to make our server alive
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install php7.3 php7.3-fpm php7.3-mysql php-json php-mbstring php-cli php-gd php-curl php-zip
RUN apt-get -y install mariadb-server
RUN apt-get -y install openssl
RUN apt-get -y install wordpress
RUN mv /usr/share/wordpress /var/www/html

#copy our ssl keys
COPY ./srcs/domain.crt /etc/nginx/ssl/
COPY ./srcs/domain.key /etc/nginx/ssl/
COPY ./srcs/nginx.conf /etc/nginx/sites-enabled

ADD https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz phpmyadmin.tar.gz

RUN tar xvzf phpmyadmin.tar.gz && mv phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin
RUN rm -rf /var/www/html/phpmyadmin.tar.gz

COPY ./srcs/config.inc.php /var/www/html/phpmyadmin
COPY ./srcs/info.php /var/www/html
COPY ./srcs/script.sh /var/www/html
COPY ./srcs/sql_script.sh /var/www/html
COPY ./srcs/wp-config.php /var/www/html/wordpress

RUN chown -R www-data /var/www/*
RUN chmod -R 775 /var/www/*
CMD bash script.sh

EXPOSE 80 443