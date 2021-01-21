mkdir -p /etc/nginx/{conf,conf.d,sites-enabled}
repo_url=https://raw.githubusercontent.com/jiz4oh/shell

nginx_conf=$repo_url/nginx/nginx.conf
mime_types=$repo_url/nginx/mime.types

echo $nginx_conf
curl $nginx_conf > /etc/nginx/nginx.conf
echo $mime_types
curl $mime_types > /etc/nginx/mime.types
