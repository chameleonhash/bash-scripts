#!/usr/bin/bash
#Bash script that will print an alphabetical list of all Termux packages

trap 'exit 130' INT

pkg install pv -y; 
for pkg in $(apt-cache pkgnames | sort);
do printf "$pkg - $(apt-cache show $pkg | grep -m 1 "Description:" | cut -c 14-)\n" | pv --rate-limit 5 --quiet --line-mode; done 
