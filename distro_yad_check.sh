#!/bin/bash


Manjaro_Distribution_Check ()
{
	cat /etc/*-release |grep ID |cut -d "=" -f "2" |grep ^manjaro$
	if [[ $? -eq 0 ]] ;then
		Distro_Validation="manjaro"
	else
	   :
	fi
}

Debian_Distribution_Check ()
{
	cat /etc/*-release |grep ID |cut -d "=" -f "2" |grep ^debian$
	if [[ $? -eq 0	]] ;then
		Distro_Validation="debian"
	else
		:
	fi
}

RedHat_Distribution_Check ()
{
	cat /etc/*-release |grep ID |cut -d "=" -f "2" |grep -e ^\"centos\"$ -e ^\"fedora\"$
	if [[ $? -eq 0	]] ;then
		Distro_Validation="redhat"
	else
		:
	fi
}

yad_validation (){
  which yad &> /dev/null
  if [[ $? -eq 0 ]] ;then
    :
  else
		if [[ $Debian_Distribution_Check =~ "manjaro"]]
  fi
}
