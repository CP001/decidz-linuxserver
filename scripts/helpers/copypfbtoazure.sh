#!/bin/bash
echo "--> Executing script helpers/copypfbtoazure.sh"
echo "--> executing ssh -p 56261 root@23.102.167.222 rm -r /var/www/decidz/websites/decidz/prod/www"
ssh -p 56261 root@23.102.167.222 rm -r /var/www/decidz/websites/decidz/prod/www
echo "--> executing scp -r -P 56261 /var/www/decidz/websites/prefirebase/www root@23.102.167.222:/var/www/decidz/websites/decidz/prod/www"
sudo scp -r -P 56261 /var/www/decidz/websites/prefirebase/www root@23.102.167.222:/var/www/decidz/websites/decidz/prod
