#!/bin/bash

#Creator : DorShamay && BigRush && Yahav && Chn555
#Purpose : all functions
#Version 1 24/02/18


# checkif user is root by UID
Root_Check(){
	if [[ $UID = 0 ]] ; then
		echo This script must be run as normal user, Exiting
		exit 1
	else
		:
	fi
}


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


# adds a student by using 2 gui prompts, entering them into an array and
# echoing it into a file
add_student (){
  if [[ -d $HOME/students ]]; then
    :
  else
    mkdir $HOME/students
  fi
  #read -p "Enter student ID : " sid
  sid=$(zenity --entry \
    --title="Add new profile" \
    --text="Enter ID of new student:" \
    --entry-text "NewStudent")
		if [[ $? == 1 ]] ; then
			return 1
		fi
  until [[ $sid =~ ^[0-9]{1,9}$ ]] ;do
    sid=$(zenity --entry \
    --title="Add new profile" \
    --text="ID invalid, Enter ID of new student:" \
    --entry-text "NewStudent")
    if [[ $sid == "NewStudent" ]]; then
      return
		elif [[ $? == 1 ]] ; then
			return 1
    else
      :
    fi
  done
  if [[ -f $HOME/students/$sid.student ]]; then
    zenity --info --text="Student already exists" --width 300
    return 1
  fi
  #read -p "Enter student name : " name
  name=$(zenity --entry \
    --title="Add new profile" \
    --text="Enter name of new student:" \
    --entry-text "NewStudent")
		if [[ $? == 1 ]] ; then
			return 1
		fi
  until [[ $name =~ ^[a-Z]{1,9}$ ]] ;do
    name=$(zenity --entry \
    --title="Add new profile" \
    --text="Name is too long or containes invalid characters, Enter name of new student:" \
    --entry-text "NewStudent")
    if [[ $name == "NewStudent" ]]; then
      return
		elif [[ $? == 1 ]] ; then
			return 1
    else
      :
    fi
  done
  # creates an array with student name and in
  sarr=($sid $name)
  # saves the array to a file, named after the student id
  echo ${sarr[*]} > $HOME/students/$sid.student && zenity --info --text="Student $name created successfully" --width 300
}


# adds grade to an existing student by pulling the array from the file,
# adding an element to it and echoing it back to the file
add_grade (){
  # inputs the file to the array
  read -a sarr < "$HOME/students/$student.student"
  # printts the array
  # echo ${sarr[*]}
  grade=$(zenity --entry \
    --title="Add new grade" \
    --text="Enter the new grade:" \
    --entry-text "NewGrade")
  until [[ $grade =~ [0-9]{1,2}|100 ]]; do
    grade=$(zenity --entry \
      --title="Grade is invalid, add new grade" \
      --text="Enter the new grade:" \
      --entry-text "NewGrade")
      if [[ $grade == "NewGrade" ]]; then
        return
      else
        :
      fi
    done
    sarr+=("$grade")
    echo ${sarr[*]} > "$HOME/students/$student.student"
    zenity --info --text="Grade $grade added successfully" --width 300
}

# provides a menu for selecting the user by listing all the student files,
# taking the ID element in the array and displaying it
Sub_Menu_Add_Grade (){
  # files lists all student files in the folder
  declare -a names
  files=($(ls $HOME/students))
  for i in ${files[*]}; do
    read -a arr < "$HOME/students/$i"
    echo ${arr[0]}
    names+=(${arr[0]})
  done
  while student=$(zenity --list --separator='' --text="Please select action" --column "Action" $(echo ${names[*]})); do
    case $student in
      *)
        add_grade
        break
      ;;
    esac
  done
}

# provides a menu for selecting the user by listing all the student files,
# taking the ID element in the array and displaying it
Sub_Menu_Remove_Student(){
  declare -a names
  files=($(ls $HOME/students))
  for i in ${files[*]}; do
    read -a arr < "$HOME/students/$i"
    echo ${arr[0]}
    names+=(${arr[0]})
  done
  while Student_To_Remove=$(zenity --list --separator='' --text="Please select action" --column "Action" $(echo ${names[*]}) ); do
    case $Student_To_Remove in
      *)
        remove_student
        break
      ;;
    esac
  done
}

# removes students by deleting the file
remove_student (){
  answer=$(zenity --list --text="Are you sure you \
  want to remove $Student_To_Remove ?"\
  --column "Action" "Yes" "No" )
  if [[ $answer =~ y|Y|"YES"|"Yes|" ]] ;then
      rm $HOME/students/$Student_To_Remove.student
  elif [[ $answer =~ n|N|"No"|"no|" ]] ;then
    zenity --info --text="Exiting"
    return 0
  else
    echo "Invalid answer. exiting"
    break
  fi
  zenity --info --text="Student $Student_To_Remove removed successfully" --width 300
}

# switches the grades of 2 students by replacing elements 2 onward of the students
# with each other
replace_students (){
  sarr_one=($(cat $HOME/students/$student_one))
  sarr_two=($(cat $HOME/students/$student_two))
  tmparray_one=(${sarr_one[@]:2})
  tmparray_two=(${sarr_two[@]:2})
  sarr_one=(${sarr_one[@]:0:2} ${tmparray_two[*]})
  sarr_two=(${sarr_two[@]:0:2} ${tmparray_one[*]})
  echo ${sarr_one[*]} > $HOME/students/$student_one
  echo ${sarr_two[*]} > $HOME/students/$student_two
  cat $HOME/students/$student_one
  cat $HOME/students/$student_two
  zenity --info --text="Students replaced  successfully" --width 300
  return 0
}

# provides a menu for selecting the user by listing all the student files,
# taking the ID element in the array and displaying it
Sub_Menu_Replace_Student (){
  # files lists all student files in the folder
  student_one=""
  student_two=""
  declare -a names
  files=($(ls $HOME/students))
  for i in ${files[*]}; do
    read -a arr < "$HOME/students/$i"
    echo ${arr[0]}
    names+=(${arr[0]})
  done
  while student1=$(zenity --list --text="Please select student 1" --column "Action" $(echo ${names[*]}) ); do
		if [[ $? -eq 1 ]] ;then
			return 1
		fi
    case $student1 in
      *)
        student_one=$student1.student
        break
        ;;
    esac
  done
  while student2=$(zenity --list --text="Please select student 2" --column "Action" $(echo ${names[*]}) ); do
    case $student2 in
          *)
            student_two=$student2.student
            answer=$(zenity --list --text="Are you sure you \
            want to replace student $student1 with $student2 ?"\
            --column "Action" "Yes" "No" )
            if [[ $answer =~ y|Y|"YES"|"Yes|" ]] ;then
                replace_students
            elif [[ $answer =~ n|N|"No"|"no|" ]] ;then
              zenity --info --text="Exiting"
              return 0
            else
              echo "Invalid answer. exiting"
              break
            fi
            return 0
          ;;
        esac
      done
}

# calculates a student avg by adding all the grades and then deviding by the number of grades
student_avg (){
	sum=0
  # opens the file into an array called sarr
  # read -a sarr < $id
  read -a  sarr < "$HOME/students/$student.student"
  maxcount=${#sarr[*]}
  elenumber=$( expr $maxcount - 2 )
  declare -x avg=0
  if [[ $maxcount -le 1 ]]; then
    zenity --info --text="The student $student has no grades" --width 300
    return
  elif [[ $maxcount -eq 2 ]]; then
    avg=${sarr[2]}
  else
  #  for i in $(eval echo {2..$( expr $maxcount - 1 )}); do
    for i in ${sarr[@]:2} ;do
        sum=$(expr $sum + $i)
      done
      TurboAnalIsisAVG=$(expr $sum / $elenumber )
  fi
  zenity --info --text="The avarage of student ${sarr[1]} is $TurboAnalIsisAVG points" --width 300
}

# provides a menu for selecting the user by listing all the student files,
# taking the ID element in the array and displaying it
Sub_Menu_Student_Avarage (){
  # files lists all student files in the folder
  declare -a names
  files=($(ls $HOME/students))
  for i in ${files[*]}; do
    read -a arr < "$HOME/students/$i"
    echo ${arr[0]}
    names+=(${arr[0]})
  done
  while student=$(zenity --list --separator='' --text="Please select action" --column "Action" $(echo ${names[*]})); do
    case $student in
      *)
        student_avg
        break
      ;;
    esac
  done
}

# calculates the highest avg by calculating avg for all the students and
# saving the highest one along with the student name
student_mavg (){
  files=$HOME/students/*.student
  mavrg=0
	tmpsum=0
  mavrgstudent="no one"
  for f in $files; do
    read -a sarr < $f
    maxcount=${#sarr[*]}
		tmpsum=0
    tmpmavg=0
    if [[ $maxcount -le 2 ]]; then
      :
    elif [[ $maxcount -eq 3 ]]; then
      tmpmavg=${sarr[2]}
      if [[ $tmpmavg -gt $mavrg ]]; then
        mavrg=$tmpmavg
        mavrgstudent=$f
      else
        :
      fi
    else
      for i in ${sarr[@]:2} ; do
        tmpsum=$(expr $tmpsum + $i)
      done
      tmpmavg=$(expr $tmpsum / $(expr $maxcount - 2))
      if [[ $tmpmavg -gt $mavrg ]]; then
        mavrg=$tmpmavg
        mavrgstudent=$f
      else
        :
      fi
    fi
  done
  #echo "The best student was ${sarr[1]} with $mavrg points avarage"
	read -a sarr < $mavrgstudent
  zenity --info \
  --text="The best student was ${sarr[1]} with $mavrg points avarage" --width=450 --height=0
}

# provides a menu for selecting the functions
mainmenu(){
  echo "Which Function would you like to use?"
  func=$(zenity --list --separator='' --text="Please select action" --column "Action"  "Add a student"  "Delete a student" \
   "Add a grade to an existing student"  "Show avarage of a student"\
   "Show the student with the highest avarage" \
   "Replace the grades of two students with each other"  "Quit" \
  --width=450 --height=350);
    	 case $func in
	  	     "Add a student" | "add_student")
              add_student
              printf "\n"
              printf "\n"
              mainmenu
           ;;
		       "Delete a student" | "remove_student")
              Sub_Menu_Remove_Student
              printf "\n"
              printf "\n"
              mainmenu
		       ;;
		       "Add a grade to an existing student" | "addgrade")
              Sub_Menu_Add_Grade
              printf "\n"
              printf "\n"
              mainmenu
	         ;;
		       "Show avarage of a student" | "avgstudent")
              Sub_Menu_Student_Avarage
              printf "\n"
              printf "\n"
              mainmenu
		       ;;
		       "Show the student with the highest avarage" | "mavgstudent")
              student_mavg
              printf "\n"
              printf "\n"
              mainmenu
		       ;;
		       "Replace the grades of two students with each other" | "replacegrade")
              Sub_Menu_Replace_Student
              printf "\n"
              printf "\n"
              mainmenu
		       ;;
           "Quit" | "q")
              exit 0
           ;;
		       *)
			        echo "Please enter a valid selection"
		       ;;
	      esac
}
