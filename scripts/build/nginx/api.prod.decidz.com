server {
    listen 443 ssl; ## listen for ipv4; this line is default and implied
 
    # Make site accessible from http://localhost/ or server IP-address
    server_name api.decidz.com;
    ssl_certificate /var/www/decidz/certs/api.decidz.com.chained.crt;
    ssl_certificate_key /var/www/decidz/certs/api.decidz.com.key;
    server_name_in_redirect off;
 
    charset utf-8;

    access_log /var/www/decidz/logs/nginx/prod_api_access.log;
    error_log /var/www/decidz/logs/nginx/prod_api_error.log;
 
    root /var/www/decidz/websites/api/prod;
    index index.php index.html index.htm;
 
    location / {
        # First attempt to serve request as file, then
        # as directory, then trigger 404
        try_files $uri $uri/ =404;
    }

    # pass the PHP scripts to FPM socket
    location ~ \.php$ {
        try_files $uri =404;
 
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
     
        fastcgi_pass php;
 
        fastcgi_index index.php;
 
        fastcgi_param SCRIPT_FILENAME /var/www/decidz/websites/api/prod$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT /var/www/decidz/websites/api/prod;
 
        # send bad requests to 404
        fastcgi_intercept_errors on;
 
        include fastcgi_params;
    }


}
