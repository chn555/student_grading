#!/bin/bash

#Creator : DorShamay
#Purpose : Make a menu to StudentGrading functions
#Version 0.0.1 06/02/18


echo "Which Function would you like to use?"

select func in "Add a student" "Delete a student" "Add a grade to an existing student" "Show avarage of a student" "Show the student with the highest avarage" "Replace the grades of two students with each other"
    do
  	 case $func in
		"Add a student" | "add_student")
      add_student
      exit 0
           ;;
		"Delete a student" | "remove_student")
      remove_student
      exit 0
		       ;;
		"Add a grade to an existing student" | "addgrade")
      add_grade
      exit 0
	         ;;
		"Show avarage of a student" | "avgstudent")
      student_avg
      exit 0
		       ;;
		"Show the student with the highest avarage" | "mavgstudent")
      student_mavg
      exit 0
		       ;;
		"Replace the grades of two students with each other" | "replacegrade")
      replace_student
      exit 0
		       ;;
		*)
			echo "Please enter a valid selection"
		;;
	esac2

done
