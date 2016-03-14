#!/bin/bash
# create directory structure
mkdir -p /var/www/decidz/websites/api/staging
mkdir -p /var/www/decidz/websites/api/prod
mkdir -p /var/www/decidz/websites/api/int
mkdir -p /var/www/decidz/websites/dcz.io/www
mkdir -p /var/www/decidz/websites/manage.decidz.com/staging
mkdir -p /var/www/decidz/websites/manage.decidz.com/prod
mkdir -p /var/www/decidz/gitrepo/decidz-webapp
mkdir -p /var/www/decidz/scripts/config
mkdir -p /var/www/decidz/logs/nginx
mkdir -p /var/www/decidz/certs
mkdir -p /var/www/decidz/temp
mkdir -p /var/www/decidz/flagfiles
mkdir -p /var/www/decidz/firebasebackups
mkdir -p /var/www/decidz/config
mkdir -p /var/www/decidz/firebasebackups
mkdir -p /var/www/decidz/websites/prefirebase/www
mkdir -p /var/www/decidz/websites/preprod/www
mkdir -p /var/www/decidz/websites/staging/www
mkdir -p /var/www/decidz/websites/int/www
mkdir -p /var/www/decidz/logs/node
chmod -R 777 /var/www/decidz

# copy scripts folder to right place
cp /var/www/decidz/gitrepo/decidz-linuxserver/scripts/* /var/www/decidz/scripts/
cp -R /var/www/decidz/gitrepo/decidz-linuxserver/scripts/config/* /var/www/decidz/scripts/config/

# copy certs over to right place
cp /var/www/decidz/gitrepo/decidz-linuxserver/scripts/build/nginx/certs/* /var/www/decidz/certs/

# allow edits of nginx.conf
chmod 777 /etc/nginx/nginx.conf

# copy nginx website configs over and enable them
cp /var/www/decidz/gitrepo/decidz-linuxserver/scripts/build/nginx/* /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/api.staging.decidz.com /etc/nginx/sites-enabled/api.staging.decidz.com
sudo ln -s /etc/nginx/sites-available/api.int.decidz.com /etc/nginx/sites-enabled/api.int.decidz.com
sudo ln -s /etc/nginx/sites-available/api.prod.decidz.com /etc/nginx/sites-enabled/api.prod.decidz.com
sudo ln -s /etc/nginx/sites-available/dcz.io /etc/nginx/sites-enabled/dcz.io
sudo ln -s /etc/nginx/sites-available/manage.decidz.com /etc/nginx/sites-enabled/manage.decidz.com
sudo ln -s /etc/nginx/sites-available/manage.staging.decidz.com /etc/nginx/sites-enabled/manage.staging.decidz.com
sudo ln -s /etc/nginx/sites-available/prefirebase.decidz.com /etc/nginx/sites-enabled/prefirebase.decidz.com
sudo ln -s /etc/nginx/sites-available/preprod.decidz.com /etc/nginx/sites-enabled/preprod.decidz.com
sudo ln -s /etc/nginx/sites-available/staging.decidz.com /etc/nginx/sites-enabled/staging.decidz.com
sudo ln -s /etc/nginx/sites-available/int.decidz.com /etc/nginx/sites-enabled/int.decidz.com
sudo ln -s /etc/nginx/sites-available/events.decidz.com /etc/nginx/sites-enabled/events.decidz.com
sudo ln -s /etc/nginx/sites-available/events.staging.decidz.com /etc/nginx/sites-enabled/events.staging.decidz.com
sudo ln -s /etc/nginx/sites-available/events.int.decidz.com /etc/nginx/sites-enabled/events.int.decidz.com

# restart NGINX
service nginx restart
service php5-fpm restart

# copy manage site over so we can use this
cp -R /var/www/decidz/gitrepo/decidz-linuxserver/websites/manage/* /var/www/decidz/websites/manage.decidz.com/prod/

# deploy mysql database for manage site
sudo mysql -uroot -pvnls83e94fulhsa < /var/www/decidz/gitrepo/decidz-linuxserver/scripts/build/mysql/manage.decidz.com.sql

# Copy postfix file over
cp /var/www/decidz/gitrepo/decidz-linuxserver/scripts/build/postfix/main.cf /etc/postfix/main.cf
cp /var/www/decidz/gitrepo/decidz-linuxserver/scripts/build/postfix/postfix_virtual /var/www/decidz/config/postfix_virtual

# reload virtual file and restart postfix service
postmap /var/www/decidz/config/postfix_virtual
service postfix reload
service postfix restart
