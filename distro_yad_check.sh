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
	line=\#\#\#\#\#\#\#\#\#\#
	Arch_Distribution_Check
	Debian_Distribution_Check
	RedHat_Distribution_Check
  which yad &> /dev/null
  if [[ $? -eq 0 ]] ;then
    :
  else
		echo "Yad not installed"
		if [[ $Distro_Validation =~ "arch" ]] ;then
			echo "$line Please enter password to install yad $line"
			sudo pacman -S yad --noconfirm &> /dev/null
			if [[ $? -eq 0 ]] ;then
				echo "Yad installation complete"
			else
				echo "Something went wrong..."
				exit
			fi
		elif [[ $Distro_Validation =~ "debian" ]] ;then
				echo "$line Please enter password to install yad $line"
				sudo apt-get install yad -y &> /dev/null
				if [[ $? -eq 0 ]] ;then
					echo "Yad installation complete"
				else
					echo "Something went wrong..."
					exit
				fi
		elif [[ $Distro_Validation =~ "redhat" ]] ;then
				echo "$line Please enter password to install yad $line"
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
yad_validation
