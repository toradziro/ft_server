#!bin/sh

bash sql_script.sh
service nginx start
service mysql restart
service php7.3-fpm start
bash