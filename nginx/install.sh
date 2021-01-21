echo 'installing wget'
sudo apt-get install -y wget -qq --no-install-recommends
sudo wget https://nginx.org/keys/nginx_signing.key

echo 'add nginx_signing.key'
sudo apt-key add nginx_signing.key

echoo 'installing lsb-release'
sudo apt-get install -y lsb-release -qq --no-install-recommends

echo 'add nginx source'
sudo sh -c 'echo deb https://nginx.org/packages/debian/ `lsb_release -cs` nginx >> /etc/apt/sources.list.d/nginx.list'
sudo sh -c 'echo deb-src https://nginx.org/packages/debian/ `lsb_release -cs` nginx >> /etc/apt/sources.list.d/nginx.list'

echo 'remove old nginx'
sudo apt-get remove nginx-common -qq --no-install-recommends
sudo apt-get update -qq --no-install-recommends

echo 'installing nginx'
sudo apt-get install -y nginx -qq --no-install-recommends
