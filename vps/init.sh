PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

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

function info() { echo -e "\e[32m[info] $*\e[0m"; }
function warn() { echo -e "\e[33m[warn] $*\e[0m"; }
function error() { echo -e "\e[31m[error] $*\e[0m"; exit 1; }

function check_depends() {
  declare -a MISSING_PACKAGES

  for depend in $*; do
    command -v $depend &>/dev/null || MISSING_PACKAGES+=($depend)
  done

  if [ ! -z "${MISSING_PACKAGES}" ]; then
    warn "The following is missing on the host and needs "
    warn "to be installed and configured before running this script again"
    error "missing: ${MISSING_PACKAGES[@]}"
  fi
}

function setTimezone() {
  info "set $1 as timezone"
  timedatectl set-timezone "$1"
}

function setSSH() {
  info 'enable RSAAuthentication'
  sed -in 's/.*RSAAuthentication.*/RSAAuthentication yes/g' /etc/ssh/sshd_config

  info 'enable PubkeyAuthentication'
  sed -in 's/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

  info 'set AuthorizedKeysFile'
  sed -in 's/.*AuthorizedKeysFile.*/AuthorizedKeysFile .ssh\/authorized_keys/g' /etc/ssh/sshd_config

  info "set $new_ssh_port as ssh port"
  sed -in "s/#Port 22/Port 22\nPort $new_ssh_port/g" /etc/ssh/sshd_config
  systemctl restart sshd
  curl -fsSL 127.0.0.1:$new_ssh_port &>/dev/null

  if [ 56 == $? ]; then
    info 'new ssh port set success'
    sed -i '/Port 22/d' /etc/ssh/sshd_config
    warn 'close the default ssh port(22) now'
    warn "your new ssh port is $new_ssh_port, please remember it!!!"
  else
    warn 'new ssh port set fail'
    warn 'may be firewall is running'
  fi
}

function enableBBR() {
  if [[ $(lsmod | grep bbr)]]; then
    info 'already enable bbr'
  else
    echo -e "net.core.default_qdisc=fq\nnet.ipv4.tcp_congestion_control=bbr" >>/etc/sysctl.conf && sysctl -p

    if [[ $(lsmod | grep bbr) ]]; then
      info 'bbr enable success'
    else
      warn 'bbr enable fail'
    fi
  fi
}

#=================================== main ===================================
check_depends curl timedatectl
setTimezone $timezone
setSSH $new_ssh_port
enableBBR
#=================================== main ===================================
