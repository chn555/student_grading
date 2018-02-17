#!/bin/bash


Arch_Distribution_Check ()
{
	cat /etc/*-release |grep ID |cut -d "=" -f "2" |grep -e ^manjaro$ -e ^arch$ &> /dev/null
	if [[ $? -eq 0 ]] ;then
		Distro_Validation="arch"
	else
	   :
	fi
}

Debian_Distribution_Check ()
{
	cat /etc/*-release |grep ID |cut -d "=" -f "2" |grep ^debian$ &> /dev/null
	if [[ $? -eq 0	]] ;then
		Distro_Validation="debian"
	else
		:
	fi
}

RedHat_Distribution_Check ()
{
	cat /etc/*-release |grep ID |cut -d "=" -f "2" |grep -e ^\"centos\"$ -e ^\"fedora\"$ &> /dev/null
	if [[ $? -eq 0	]] ;then
		Distro_Validation="redhat"
	else
		:
	fi
}

yad_validation ()
{
  which yad &> /dev/null
  if [[ $? -eq 0 ]] ;then
    :
  else
		if [[ $Distro_Validation =~ "arch" ]] ;then
			sudo pacman -S yad --noconfirm &> /dev/null
			if [[ $? -eq 0 ]] ;then
				echo "Yad installation complete"
			else
				echo "Something went wrong..."
				exit
			fi
		elif [[ $Distro_Validation =~ "debian" ]] ;then
				sudo apt-get install yad -y &> /dev/null
				if [[ $? -eq 0 ]] ;then
					echo "Yad installation complete"
				else
					echo "Something went wrong..."
					exit
				fi
		elif [[ $Distro_Validation =~ "redhat" ]] ;then
				sudo yum install yad -y &> /dev/null
				if [[ $? -eq 0 ]] ;then
						echo "Yad installation complete"
				else
						echo "Something went wrong..."
						exit
				fi
		else
				echo "This script does not support your automatic installation of yad on your distribution"
				echo "However you can install yad manualy and run again this script"
				exit
		fi
  fi
}
Arch_Distribution_Check
Debian_Distribution_Check
RedHat_Distribution_Check
yad_validation
