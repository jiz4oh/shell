Red_font_prefix="\033[31m"
Green_font_prefix="\033[32m"
Yellow_font_prefix="\033[33m"
Blue_font_prefix="\033[34m"
Azure_font_prefix="\033[36m"

Font_color_suffix="\033[0m"

LOG_DEBUG() {
  echo -e "${Azure_font_prefix}[Debug] $1${Font_color_suffix}"
}

LOG_INFO() {
  echo -e "${Green_font_prefix}[Info] $1${Font_color_suffix}"
}

LOG_NOTICE() {
  echo -e "${Blue_font_prefix}[Notice] $1${Font_color_suffix}"
}

LOG_WARNING() {
  echo -e "${Yellow_font_prefix}[Warning] $1${Font_color_suffix}"
}

LOG_ERROR() {
  echo -e "${Red_font_prefix}[Error] $1${Font_color_suffix}"
}
