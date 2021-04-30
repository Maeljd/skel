#!/bin/bash
###
#
# Author: Maël
# Date:
# Version: 1.0
# Desc:
###
#############
### Variables
DEBUG=false
OS_DETECTED="$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')"
CONTINUE_ON_UNDETECTED_OS=false
USER_ID=$(id -u)
REQUIRE_ROOT=false
REQUIRE_OPTION=false

#####################
### Commons functions
function debug(){
  cat << EOF
  OS Detected     : $OS_DETECTED
  User ID         : $USER_ID
EOF
}

function usage(){
  cat <<EOF

blablablabla

  Usage:
        $0 --help

    -h  |  --help              Show this help
EOF
}

function msg(){

  local GREEN="\\033[1;32m"
  local NORMAL="\\033[0;39m"
  local RED="\\033[1;31m"
  local PINK="\\033[1;35m"
  local BLUE="\\033[1;34m"
  local WHITE="\\033[0;02m"
  local YELLOW="\\033[1;33m"

  if [ "$1" == "ok" ]; then
    echo -e "[$GREEN  OK  $NORMAL] $2"
  elif [ "$1" == "ko" ]; then
    echo -e "[$RED ERROR $NORMAL] $2"
  elif [ "$1" == "warn" ]; then
    echo -e "[$YELLOW WARN $NORMAL] $2"
  elif [ "$1" == "info" ]; then
    echo -e "[$BLUE INFO $NORMAL] $2"
  fi
}

function detect_os(){
  if echo "$OS_DETECTED" | grep -q "debian"; then
    msg info "OS detected : Debian"
  elif echo "$OS_DETECTED" | grep -q "ubuntu"; then
    msg info "OS detected : Ubuntu"
  elif echo "$OS_DETECTED" | grep -q "fedora"; then
    msg info "OS detected : Fedora"
  elif echo "$OS_DETECTED" | grep -q "centos"; then
    msg info "OS detected : Centos"
  elif echo "$OS_DETECTED" | grep -q "arch"; then
    msg info "OS detected : Archlinux"
  else
    if $CONTINUE_ON_UNDETECTED_OS; then
      msg info "Unable to detect os"
    else
      msg ko "Unable to detect os and CONTINUE_ON_UNDETECTED_OS is set to false"
      exit 1
    fi
  fi
}

#################
### Main function
function main(){
  msg info "Welcome in the main function"
}

##################
### Commons checks

if [ $USER_ID -ne 0 ] && $REQUIRE_ROOT ; then
   msg ko "Oops, this script must be run as root !"
   exit 1
fi

if [[ $# -eq 0 ]] && $REQUIRE_OPTION; then
  msg ko "Oops, This script require options"
  usage
  exit 1
fi


while [[ $# -gt 0 ]]; do
  case "$1" in
    -h | --help)
      usage
      exit 0
      ;;
#    -u | --user)
#      USER="$2"
#      shift 2
#      ;;
      *)
      msg ko "$1 : Unkown option"
      usage
      exit 1
      ;;
  esac
done

detect_os

if $DEBUG; then
  debug
  exit 0
else
  main
fi
