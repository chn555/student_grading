#!/bin/bash

#Creator : fuck a you DorShamay && BigRush && Yahav && Chn555
#Purpose : Make a menu to StudentGrading functions
#Version 0.0.1 12/02/18


add_student (){
  if [[ -d students ]]; then
    :
  else
    mkdir students
  fi
  #read -p "Enter student ID : " sid
  sid=$(zenity --entry \
    --title="Add new profile" \
    --text="Enter ID of new student:" \
    --entry-text "NewStudent")
  until [[ $sid =~ ^[0-9]{3}$ ]] ;do
    sid=$(zenity --entry \
    --title="Add new profile" \
    --text="ID invalid, Enter ID of new student:" \
    --entry-text "NewStudent")
    if [[ $sid == "NewStudent" ]]; then
      return
    else
      :
    fi
  done
  #read -p "Enter student name : " name
  name=$(zenity --entry \
    --title="Add new profile" \
    --text="Enter name of new student:" \
    --entry-text "NewStudent")
  until [[ $name =~ ^[a-Z]{,9}$ ]] ;do
    name=$(zenity --entry \
    --title="Add new profile" \
    --text="Name is too long or containes invalid characters, Enter name of new student:" \
    --entry-text "NewStudent")
    if [[ $name == "NewStudent" ]]; then
      return
    else
      :
    fi
  done
  # creates an array with student name and in
  sarr=($sid $name)
  # saves the array to a file, named after the student id
  echo ${sarr[*]} > students/$sid.student
  zenity --info --text="Student $name created successfully" --width 300
}


add_grade (){
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


Sub_Menu_Add_Grade (){
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


remove_student (){
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


replace_students (){
  sarr_one=($(cat students/$student_one))
  sarr_two=($(cat students/$student_two))
  tmparray_one=(${sarr_one[@]:2})
  tmparray_two=(${sarr_two[@]:2})
  sarr_one=(${sarr_one[@]:0:2} ${tmparray_two[*]})
  sarr_two=(${sarr_two[@]:0:2} ${tmparray_one[*]})
  echo ${sarr_one[*]} > students/$student_one
  echo ${sarr_two[*]} > students/$student_two
  cat students/$student_one
  cat students/$student_two
  echo "Succeeded"
}


Sub_Menu_Replace_Student (){
  # files lists all student files in the folder
  files=($(ls students))
  student_one=""
  student_two=""
  # echo ${files[*]}
  # adds all student file names to array
  echo Select student one
  select opt in "${files[@]}" "Stop the script"; do
    case $opt in
      *.student)
        echo "Student file $opt selected"
        #sid=$opt
        #echo $opt
        student_one=$opt
        echo $student_one
        break
        ;;
      "Stop the script")
        echo "You chose to stop"
        exit
        ;;
      *)
        echo "This is not a number"
        ;;
    esac
  done
  echo Select student two
      select opt in "${files[@]}" "Stop the script"; do
        case $opt in
          *.student)
            echo "Student file $opt selected"
            #sid=$opt
            #echo $opt
            student_two=$opt
            echo $student_two
            read -p "Are you sure you want to replace $student_one grades with $student_two? [y/n]" answer
            if [[ $answer =~ y|Y|"YES"|"yes" ]] ;then
              replace_students
            elif [[ $answer =~ n|N|"NO"|"no" ]] ;then
              echo "FuckAYou then"
              break
            else
              echo "Invalid answer. exiting"
              break
            fi
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


student_avg (){
  # opens the file into an array called sarr
  # read -a sarr < $id
  read -a  sarr < "students/$opt"
  maxcount=${#sarr[*]}
  elenumber=$( expr $maxcount - 2 )
  declare -x avg=0
  if [[ $maxcount -le 1 ]]; then
    :
  elif [[ $maxcount -eq 2 ]]; then
    avg=${sarr[2]}
  else
  #  for i in $(eval echo {2..$( expr $maxcount - 1 )}); do
    for i in ${sarr[@]:2} ;do
        sum=$(expr $sum + $i)
      done
      TurboAnalIsisAVG=$(expr $sum / $elenumber )
  fi
  echo "The avarage of student ${sarr[1]} is $TurboAnalIsisAVG points."
}


Sub_Menu_Student_Avarage (){
  # files lists all student files in the folder
  files=($(ls students))
  echo ${files[*]}
  declare -a names
  # adds all student file names to array
  echo Select student
    select opt in "${files[@]}" "Stop the script"; do
      case $opt in
        *.student)
          echo "Student file $opt selected"
          #sid=$opt
          #echo $opt
          student_avg
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


student_mavg (){
  files=students/*.student
  mavrg=0
  mavrgstudent="no one"
  for f in $files; do
    read -a sarr < $f
    maxcount=${#sarr[*]}
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
  zenity --info \
  --text="The best student was ${sarr[1]} with $mavrg points avarage" --width=450 --height=0
}


mainmenu(){
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


mainmenu
