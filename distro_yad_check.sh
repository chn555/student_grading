#!/bin/bash

<<COMMENT
 This script will Check if zenity is installed on the computer, if not the script will install it according
 to the installer that is available on the user's system.
 If this script does not support the installer that is currently on the user's system,
 the script will print to the user that he can install zenity manually and run the script again.
COMMENT

## Checks if the user has pacman installer by running the "command" command on "pacman" and examining the exit code to check if the installer exists
Pacman_Check (){
	command -v pacman &> /dev/null
	if [[ $? -eq 0 ]] ;then
		Installer_Validation="PacManINST"
	else
	   :
	fi
}

## Checks if the user has apt-get installer by running the "command" command on "apt-get" and examining the exit code to check if the installer exists
Apt-Get_Check (){
	command -v apt-get &> /dev/null
	if [[ $? -eq 0	]] ;then
		Installer_Validation="AptGetINST"
	else
		:
	fi
}

## Checks if the user has yum installer by running the "command" command on "yum" and examining the exit code to check if the installer exists
Yum_Check (){
	command -v yum &> /dev/null
	if [[ $? -eq 0	]] ;then
		Installer_Validation="YumINST"
	else
		:
	fi
}

## Checks if the user has dnf installer by running the "command" command on "dnf" and examining the exit code to check if the installer exists
Dnf_Check (){
	command -v dnf &> /dev/null
	if [[ $? -eq 0	]] ;then
		Installer_Validation="DnfINST"
	else
		:
	fi
}

<<COMMENT
Checks if zentity is installed on the system and if not the script will install zenity based on the installer that is available,
if the user is running on a distribution that does not have an installer that is supported by this script, it will print to the user that
he can install zenity manually and run the script again.
COMMENT
zenity_validation (){
	line=\#\#\#\#\#\#\#\#\#\#
	Pacman_Check
	Apt-Get_Check
	Yum_Check
	Dnf_Check
  which zenity &> /dev/null
  if [[ $? -eq 0 ]] ;then
    :
  else
		echo "zenity not installed"
		if [[ $Installer_Validation =~ "PacManINST" ]] ;then
			echo "$line Please enter password to install zenity $line"
			sudo pacman -S zenity --noconfirm &> /dev/null
			if [[ $? -eq 0 ]] ;then
				echo "$line zenity installation complete $line"
			else
				echo "$line Something went wrong $line"
				exit
			fi
		elif [[ $Installer_Validation =~ "AptGetINST" ]] ;then
				echo "$line Please enter password to install zenity $line"
				sudo apt-get install zenity -y &> /dev/null
				if [[ $? -eq 0 ]] ;then
					echo "$line zenity installation complete $line"
				else
					echo "$line Something went wrong $line"
					exit
				fi
		elif [[ $Installer_Validation =~ "YumINST" ]] ;then
				echo "$line Please enter password to install zenity $line"
				sudo yum install zenity -y &> /dev/null
				if [[ $? -eq 0 ]] ;then
						echo "$line zenity installation complete $line"
				else
						echo "$line Something went wrong $line"
						exit
				fi
		elif [[ $Installer_Validation =~ "DnfINST" ]] ;then
				echo "$line Please enter password to install zenity $line"
				sudo dnf install zenity -y &> /dev/null
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
