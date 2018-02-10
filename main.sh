#!/bin/bash
#
#
###########################################
#                                         #
# Created by chn555, Dor, Yahav & BigRush #
# Date : 10/2/2018                         #
###########################################
#
#
#

add_student ()
{

  read -p "Enter student ID : " sid

  until [[ $sid =~ ^[0-9]{3}$ ]] ;do
    read -p "Invalid ID number, please try again : " sid
  done

  read -p "Enter student name : " name

  until [[ $name =~ ^[a-Z]{,9}$ ]] ;do
    read -p "Name is too long or containes invalid characters: " name
  done
    # creates an array with student name and in
    sarr=($sid $name)
    # saves the array to a file, named after the student id
    echo ${sarr[*]} > students/$sid.student
    echo "Student $name created"

}





remove_student ()
{

files=($(ls students))
echo ${files[*]}
select opt in "${files[@]}" "Stop the script"; do
	case $opt in
		*.student)
		  	echo "Student will be removed shortly"
			echo $opt
			rm students/$opt
			break
			;;
		"Stop the script")
			echo "You chose to exit"
			break
			;;
		*)
			echo "This is invalid"
			;;
		esac
	done
}



add_grade()
{


# inputs the file to the array
read -a sarr < "students/$opt"

# printts the array
# echo ${sarr[*]}
read -p "Enter grade to be added : " grade
if [[ $grade =~ [0-9]{1,3} ]]; then

  sarr+=("$grade")
  echo ${sarr[*]} > "students/$opt"
  echo "Grade $grade added "
else
  echo Grade is invalid, exiting and Fuck-a-you
fi

}

Sub_Menu_Add_Grade ()
{
# files lists all student files in the folder
files=($(ls students))
echo ${files[*]}
declare -a names

echo Select student
    select opt in "${files[@]}" "Stop the script"; do
    case $opt in
      *.student)
        echo "Student file $opt selected"
        add_grade
        break
        ;;
      "Stop the script")
        echo "You chose to stop"
        break
        ;;
      *)
        echo "This is not a number"
        ;;
    esac
  done

}




mainmenu()
{

echo "Which Function would you like to use?"


select func in "Add a student" "Delete a student" "Add a grade to an existing student" "Show avarage of a student" "Show the student with the highest avarage" "Replace the grades of two students with each other" "Quit"
    do
  	 case $func in
		"Add a student" | "add_student")
      add_student
        printf "\n"
        printf "\n"
      mainmenu
           ;;
		"Delete a student" | "remove_student")
      remove_student
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
      student_avg
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

done
}
