#!/bin/bash


Arch_Distribution_Check (){
	cat /etc/*-release |grep ID |cut -d "=" -f "2" |grep -e ^manjaro$ -e ^arch$ &> /dev/null
	if [[ $? -eq 0 ]] ;then
		Distro_Validation="arch"
	else
	   :
	fi
}

Debian_Distribution_Check (){
	cat /etc/*-release |grep ID |cut -d "=" -f "2" |grep ^debian$ &> /dev/null
	if [[ $? -eq 0	]] ;then
		Distro_Validation="debian"
	else
		:
	fi
}

RedHat_Distribution_Check (){
	cat /etc/*-release |grep ID |cut -d "=" -f "2" |grep -e ^\"centos\"$ -e ^\"fedora\"$ &> /dev/null
	if [[ $? -eq 0	]] ;then
		Distro_Validation="redhat"
	else
		:
	fi
}

zenity_validation (){
	line=\#\#\#\#\#\#\#\#\#\#
	Arch_Distribution_Check
	Debian_Distribution_Check
	RedHat_Distribution_Check
  which zenity &> /dev/null
  if [[ $? -eq 0 ]] ;then
    :
  else
		echo "zenity not installed"
		if [[ $Distro_Validation =~ "arch" ]] ;then
			echo "$line Please enter password to install zenity $line"
			sudo pacman -S zenity --noconfirm &> /dev/null
			if [[ $? -eq 0 ]] ;then
				echo "$line zenity installation complete $line"
			else
				echo "$line Something went wrong $line"
				exit
			fi
		elif [[ $Distro_Validation =~ "debian" ]] ;then
				echo "$line Please enter password to install zenity $line"
				sudo apt-get install zenity -y &> /dev/null
				if [[ $? -eq 0 ]] ;then
					echo "$line zenity installation complete $line"
				else
					echo "$line Something went wrong $line"
					exit
				fi
		elif [[ $Distro_Validation =~ "redhat" ]] ;then
				echo "$line Please enter password to install zenity $line"
				sudo yum install zenity -y &> /dev/null
				if [[ $? -eq 0 ]] ;then
						echo "$line zenity installation complete $line"
				else
						echo "$line Something went wrong $line"
						exit
				fi
		else
				echo "This script does not support automatic installation of zenity on your distribution."
				echo "However you can install zenity manualy and run this script again."
				exit
		fi
  fi
}
zenity_validation
