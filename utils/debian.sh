get_debian_version() {
  if [ -f /etc/os-release ]; then
    source /etc/os-release
    echo "$VERSION_CODENAME"
  fi
}
