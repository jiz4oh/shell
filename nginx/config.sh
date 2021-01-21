mkdir -p /etc/nginx/{conf,conf.d,sites-enabled}
repo_url=https://raw.githubusercontent.com/jiz4oh/shell/master/nginx/resources

nginx_conf=$repo_url/nginx.conf
mime_types=$repo_url/mime.types

echo "use $nginx_conf as nginx.conf"
curl $nginx_conf > /etc/nginx/nginx.conf

echo "use $mime_types as mime.types"
curl $mime_types > /etc/nginx/mime.types
