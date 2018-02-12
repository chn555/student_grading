#!/bin/bash

#Creator : fuck a you DorShamay
#Purpose : Make a menu to StudentGrading functions
#Version 0.0.1 06/02/18
mainmenu()
{

echo "Which Function would you like to use?"


func=$(zenity --list --text="Please select action" --radiolist --column "Pick" --column "Action" FALSE "Add a student" FALSE "Delete a student" FALSE "Add a grade to an existing student" FALSE "Show avarage of a student" FALSE "Show the student with the highest avarage" FALSE "Replace the grades of two students with each other" FALSE "Quit" --width=450 --height=350);

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
      add_grade
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
      replace_student
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

mainmenu
