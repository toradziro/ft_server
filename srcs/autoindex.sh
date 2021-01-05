#!/bin/bash

if grep -q "autoindex on" /etc/nginx/sites-enabled/nginx.conf
then
	sed -i "s/autoindex on/autoindex off/" /etc/nginx/sites-enabled/nginx.conf
	service nginx restart
elif grep -q "autoindex off" /etc/nginx/sites-enabled/nginx.conf
then
	sed -i "s/autoindex off/autoindex on/" /etc/nginx/sites-enabled/nginx.conf
	service nginx restart
fi
