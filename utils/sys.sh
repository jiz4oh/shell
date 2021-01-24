# Usage:
#   $(check_sys)

check_sys() {
  OS=$(uname -s)
  if [ "${OS}" == "Darwin" ]; then
    sudo brew install git
  elif [ "${OS}" == "Linux" ]; then
    if [ -f /etc/centos-release ]; then
      echo "centos"
    elif [ -f /etc/redhat-release ]; then
      echo "rhel"
    elif cat /etc/issue | grep -q -E -i "centos"; then
      echo "centos"
    elif cat /etc/issue | grep -q -E -i "red hat|redhat"; then
      echo "rhel"
    elif cat /etc/issue | grep -q -E -i "debian"; then
      echo "debian"
    elif cat /etc/issue | grep -q -E -i "ubuntu"; then
      echo "ubuntu"
    elif cat /proc/version | grep -q -E -i "centos"; then
      echo "centos"
    elif cat /proc/version | grep -q -E -i "red hat|redhat"; then
      echo "rhel"
    elif cat /proc/version | grep -q -E -i "debian"; then
      echo "debian"
    elif cat /proc/version | grep -q -E -i "ubuntu"; then
      echo "ubuntu"
    elif [ -f /etc/os-release ]; then
      source /etc/os-release
      echo "$ID"
    else
      echo "Unknown"
    fi
  else
    echo "${OS}"
  fi
}

# package manager install
pm_install() {
  case $(check_sys) in
  debian | ubuntu | devuan)
    apt-get update
    echo "Installing $@"
    apt-get install -y "$@" -qq --no-install-recommends
    ;;
  centos | rhel)
    yum update
    echo "Installing $@"
    yum install -y "$@" -q
    ;;
  *)
    echo 'Unknown system, exit!'
    exit 1
    ;;
  esac
}
