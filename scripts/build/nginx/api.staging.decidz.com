server {
    listen 80; ## listen for ipv4; this line is default and implied
 
    # Make site accessible from http://localhost/ or server IP-address
    server_name api.staging.decidz.com;
    server_name_in_redirect off;
 
    charset utf-8;

    access_log /var/www/decidz/logs/nginx/staging_api_access.log;
    error_log /var/www/decidz/logs/nginx/staging_api_error.log;
 
    root /var/www/decidz/websites/api/staging;
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
 
        fastcgi_param SCRIPT_FILENAME /var/www/decidz/websites/api/staging$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT /var/www/decidz/websites/api/staging;
 
        # send bad requests to 404
        fastcgi_intercept_errors on;
 
        include fastcgi_params;
        fastcgi_read_timeout 300;
    }


}
