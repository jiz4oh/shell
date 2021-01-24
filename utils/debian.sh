get_debian_version() {
  if [ -f /etc/os-release ]; then
    source /etc/os-release
    echo "$VERSION_CODENAME"
  else
    dpkg -s lsb-release &>/dev/null
    if [ 1 == $? ]; then
      apt-get install -y lsb-release -qq --no-install-recommends
    fi
    lsb_release -cs
  fi
}
