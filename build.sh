#!/bin/bash

BASE_DIR=$1

mkdir -p $BASE_DIR/{burp,analysis,assets/{domain,ipv4,ipv6,ss},content/{dir,params,ports,secrets,tech,urls},tmp}

touch $BASE_DIR/tracker.md
mkdir $BASE_DIR/.config
touch $BASE_DIR/.config/config.ini

echo "Created a config.ini file inside $BASE_DIR/.config" | lolcat

echo "Directory structure created successfully under '$BASE_DIR/'" | lolcat


