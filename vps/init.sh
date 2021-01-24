PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
curl -fsSL 'https://raw.githubusercontent.com/jiz4oh/shell/master/utils/log.sh' -o .tmp.sh && source .tmp.sh && rm .tmp.sh

#=================================================
#	System Required: CentOS/Debian/Ubuntu
#	Description: Init VPS
#	Script Version: 1.0.0
#	Author: jiz4oh
#=================================================

# Place at:
# curl raw.githubusercontent.com/jiz4oh/shell/master/init.sh > ./init_vps.sh && chmod +x ./init_vps.sh && bash ./init_vps.sh -t Asia/Shanghai -p 23232

# Optional flags:
#            -t Asia/Shanghai          # timezone, default: Asia/Shanghai
#            -p 23232                  # port, default: 23232

timezone=Asia/Shanghai
new_ssh_port=23232

function setTimezone() {
  LOG_INFO "set $1 as timezone"
  timedatectl set-timezone "$1"
}

function setSSH() {
  LOG_DEBUG 'enable RSAAuthentication'
  sed -in 's/.*RSAAuthentication.*/RSAAuthentication yes/g' /etc/ssh/sshd_config

  LOG_DEBUG 'enable PubkeyAuthentication'
  sed -in 's/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

  LOG_DEBUG 'set AuthorizedKeysFile'
  sed -in 's/.*AuthorizedKeysFile.*/AuthorizedKeysFile .ssh\/authorized_keys/g' /etc/ssh/sshd_config

  LOG_DEBUG "set $new_ssh_port as ssh port"
  sed -in "s/#Port 22/Port 22\nPort $new_ssh_port/g" /etc/ssh/sshd_config
  systemctl restart sshd
  curl -fsSL 127.0.0.1:$new_ssh_port >/dev/null

  if [ 56 == $? ]; then
    LOG_INFO 'new ssh port set success'
    sed -i '/Port 22/d' /etc/ssh/sshd_config
    LOG_WARNING 'close the default ssh port(22) now'
    LOG_WARNING "your new ssh port is $new_ssh_port, please remember it!!!"
  else
    LOG_ERROR 'new ssh port set fail'
    LOG_ERROR 'may be firewall is running'
  fi
}

function enableBBR() {
  lsmod | grep bbr >/dev/null

  if [ 0 == $? ]; then
    LOG_INFO 'already enable bbr'
  else
    echo -e "net.core.default_qdisc=fq\nnet.ipv4.tcp_congestion_control=bbr" >>/etc/sysctl.conf && sysctl -p
    lsmod | grep bbr

    if [ 0 == $? ]; then
      LOG_INFO 'bbr enable success'
    else
      LOG_ERROR 'bbr enable fail'
    fi
  fi
}

setTimezone $timezone
setSSH $new_ssh_port
enableBBR
