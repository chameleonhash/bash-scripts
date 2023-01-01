#!/usr/bin/bash
#Bash script that will print an alphabetical list of all Termux packages

trap 'exit 130' INT

pkg upgrade -y;
pkg install pv -y; pkg install figlet -y;
clear;

figlet -w 135 -c -f "bigmono9" "Termux Packages"
figlet -w 135 -c -f "mono9" "ctrl c to stop"
figlet -w 135 -c -f "script" "by chameleonhash"
figlet -w 135 -c -f "bigmono9" "================"
for pkg in $(apt-cache pkgnames | sort);
do printf "$pkg - $(apt-cache show $pkg | grep -m 1 "Description:" | cut -c 14-)\n" | pv --rate-limit 5 --quiet --line-mode; done 
