#!/bin/bash
# 
# AUTIDZ - Sofware utils installer alinko version.
# Author : shutdown57 < alinkokomansuby@gmail.com >
# Date modified : 16 September 2019
# Version : 1.1
# Tested ubuntu 18.04 LTS

m="\033[1;31m"
k="\033[1;33m"
h="\033[1;32m"
b="\033[1;34m"
bl="\033[0;34m"
n="\033[1;0m"

s57_cekonek(){
clear
echo "Checking internet Connection..."
ping 8.8.8.8 -c 3 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
echo -e $h"[+] Yokatta ! You Are Online !"$n
sleep 2
else
echo -e $m"[-] Gomennasai.. You Are Offline :( OR You internet to slow.."
sleep 3
s57_main__
fi
}
s57_alert()
{
	echo ""
	echo -e ${b}"[!]${n}[`date +%H:%m:%S`] ${1} ... ~ ${bl}./shutdown57${n}"
	echo ""
}
s57_server_utils__()
{
	s57_cekonek
	s57_alert "Updating system..."
	apt-get update -y
	s57_alert "Installing Apache2 & PHP ..."
	apt-get install apache2 libapache2-mod-php php php-common php-curl php-zip php-mysql php-mbstring -y
	
	s57_alert "Creating info.php "
	echo "<?php" >> /var/www/html/info.php
	echo "phpinfo();" >> /var/www/html/info.php
	echo "# by : alinko" >> /var/www/html/info.php
	echo "?>" >> /var/www/html/info.php
	xdg-open "http://localhost/info.php" >> /dev/null 2>&1
	s57_alert "Installing mariadb-server"
	apt-get install mariadb-server -y
	s57_alert "MySQL Installation secure"
	mysql_secure_installation
	s57_alert "Installing phpmyadmin"
	apt-get install phpmyadmin -y
	s57_alert "Activating mod rewrite "
	a2enmod rewrite
	s57_alert "Restarting apache2"
	/etc/init.d/apache2 restart
	echo ""
	echo "~ DONE ~"
	sleep 2
}
s57_sublime__()
{
	s57_cekonek
	s57_alert "Downloading Repository Sublime Text"
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
	s57_alert "Installing dependencies"
	apt-get install apt-transport-https -y
	s57_alert "Adding Repository Sublime Text"
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	s57_alert "Updating system"
	apt-get update -y
	s57_alert "Installing sublime-text"
	apt-get install sublime-text -y
	echo ""
	echo "~ DONE ~"
	sleep 2
}
s57_brackets__()
{
	s57_cekonek
	s57_alert "Adding repository Brackets .."
	sudo add-apt-repository ppa:webupd8team/brackets
	s57_alert "Updating system"
	apt-get update -y
	s57_alert "Installing Brackets"
	apt-get install brackets -y
	echo ""
	echo "~ DONE ~"
	sleep 2
}
s57_mv__()
{
	s57_cekonek
	s57_alert "Installing mpv from Repository"
	apt-get install mpv -y
	s57_alert "Installing moc from Repository"
	apt-get install moc -y
	echo ""
	echo "~ DONE ~"
	echo ""
	sleep 2
}
s57_usu__()
{
	s57_cekonek
	s57_alert "Installing ubuntu-restricted-extras "
	read -p "Ini akan memakan waktu yang cukup lama, apa anda ingin melanjutkan? [Y/n]" yn 
	if [[ $yn == "Y" || $yn == "" || $yn == "y" ]]; then
		apt-get install ubuntu-restricted-extras -y
	fi
	echo ""
	echo "~ DONE ~"
	sleep 2
}
s57_pmod__()
{
	read -p "Module >>" module
	cek=$(apt-cache search --names-only "php-${module}")
	if [[ $cek =~  $module ]]; then
		apt-get install php-${module} -y
	else
		s57_alert "Module php-${module} not exists in repository !"
		exit
	fi
}
s57_banner()
{
	clear
	printf "${k}

    _         _   _     _     
   / \  _   _| |_(_) __| |____
  / _ \| | | | __| |/ _' |_  /
 / ___ \ |_| | |_| | (_| |/ / 
/_/   \_\__,_|\__|_|\__,_/___|
${n}

+------ [ ${b}Alinko Priv8 Software utils.${n}
 +----- [ ${k}Version :${n} 1.1 2019 Ubuntu 18.x or latest.
  +---- [ ${m}Installer for fast work.${n}
   +--- [ ${h}DEBIAN & UBUNTU BASED ${n}

[1] Lampp 
[2] Sublime Text
[3] Brackets
[4] Music & Video Player (mpv,mocp)
[5] Ubuntu Software Utils.
[6] PHP Module
[7] Programming Package
"
}
s57_main__(){

s57_banner

read -p "shutdown57 >>" aut
if [[ $aut == 1 ]]; then

	s57_server_utils__
	s57_main__

elif [[ $aut == 2 ]]; then

	s57_sublime__
	s57_main__

elif [[ $aut == 3 ]]; then

	s57_brackets__
	s57_main__

elif [[ $aut == 4 ]]; then

	s57_mv__
	s57_main__

elif [[ $aut == 5 ]]; then

	s57_usu__
	s57_main__

elif [[ $aut == 6 ]]; then
	
	s57_pmod__
	s57_main__

elif [[ $aut == 0 ]]; then

	s57_init__
	s57_main__
elif [[ $aut == 7 ]]; then
	s57_server_utils__
	s57_sublime__
	s57_brackets__
	s57_main__

else
	s57_main__
fi
}

if [[ `whoami` == "root" ]]; then
	s57_main__
else
	echo "[JALANKAN SCRIPT INI DENGAN SUPER USER / ROOT ]"
fi
