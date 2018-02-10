#!/bin/bash

#Creator : DorShamay
#Purpose : Make a menu to StudentGrading functions
#Version 0.0.1 06/02/18
mainmenu()
{

echo "Which Function would you like to use?"


select func in "Add a student" "Delete a student" "Add a grade to an existing student" "Show avarage of a student" "Show the student with the highest avarage" "Replace the grades of two students with each other" "Quit"
    do
  	 case $func in
		"Add a student" | "add_student")
      add_student
      printf \n
      printf \n
      mainmenu
           ;;
		"Delete a student" | "remove_student")
      remove_student
      printf \n
      printf \n
      mainmenu
		       ;;
		"Add a grade to an existing student" | "addgrade")
      add_grade
      printf \n
      printf \n
      mainmenu
	         ;;
		"Show avarage of a student" | "avgstudent")
      student_avg
      printf \n
      printf \n
      mainmenu
		       ;;
		"Show the student with the highest avarage" | "mavgstudent")
      student_mavg
      printf \n
      printf \n
      mainmenu
		       ;;
		"Replace the grades of two students with each other" | "replacegrade")
      replace_student
      printf \n
      printf \n
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

mainmenu
