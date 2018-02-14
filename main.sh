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
  sid=$(yad --entry \
    --title="Add new profile" \
    --text="Enter ID of new student:" \
    --entry-text "NewStudent")
  until [[ $sid =~ ^[0-9]{3}$ ]] ;do
    sid=$(yad --entry \
    --title="Add new profile" \
    --text="ID invalid, Enter ID of new student:" \
    --entry-text "NewStudent")
    if [[ $sid == "NewStudent" ]]; then
      return
    else
      :
    fi
  done
  if [[ -f students/$sid.student ]]; then
    yad --info --text="Student already exists" --width 300
    return 1
  fi
  #read -p "Enter student name : " name
  name=$(yad --entry \
    --title="Add new profile" \
    --text="Enter name of new student:" \
    --entry-text "NewStudent")
  until [[ $name =~ ^[a-Z]{,9}$ ]] ;do
    name=$(yad --entry \
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
  echo ${sarr[*]} > students/$sid.student && yad --info --text="Student $name created successfully" --width 300
}


add_grade (){
  # inputs the file to the array
  read -a sarr < "students/$student.student"
  # printts the array
  # echo ${sarr[*]}
  grade=$(yad --entry \
    --title="Add new grade" \
    --text="Enter the new grade:" \
    --entry-text "NewGrade")
  until [[ $grade =~ [0-9]{1,2}|100 ]]; do
    grade=$(yad --entry \
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
    echo ${sarr[*]} > "students/$student.student"
    yad --info --text="Grade $grade added successfully" --width 300
}


Sub_Menu_Add_Grade (){
  # files lists all student files in the folder
  declare -a names
  files=($(ls students))
  for i in ${files[*]}; do
    read -a arr < "students/$i"
    echo ${arr[0]}
    names+=(${arr[0]})
  done
  while student=$(yad --list --separator='' --text="Please select action" --column "Action" $(echo ${names[*]}) \
  --width=450 --height=350 --print--all); do
    case $student in
      *)
        add_grade
        break
      ;;
    esac
  done
}


Sub_Menu_Remove_Student(){
  declare -a names
  files=($(ls students))
  for i in ${files[*]}; do
    read -a arr < "students/$i"
    echo ${arr[0]}
    names+=(${arr[0]})
  done
  while Student_To_Remove=$(yad --list --separator='' --text="Please select action" --column "Action" $(echo ${names[*]}) \
  --width=450 --height=350 --print--all); do
    case $Student_To_Remove in
      *)
        remove_student
        break
      ;;
    esac
  done
}


remove_student (){
  answer=$(yad --list --seperator='' --text="Are you sure you \
  want to remove $Student_To_Remove ?"\
  --column "Action" "Yes" "No" )
  if [[ $answer =~ y|Y|"YES"|"Yes|" ]] ;then
      rm students/$Student_To_Remove.student
  elif [[ $answer =~ n|N|"No"|"no|" ]] ;then
    yad --info --text="Exiting"
    return 0
  else
    echo "Invalid answer. exiting"
    break
  fi
  yad --info --text="Student $Student_To_Remove removed successfully" --width 300
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
  yad --info --text="Students replaced  successfully" --width 300
  return 0
}


Sub_Menu_Replace_Student (){
  # files lists all student files in the folder
  student_one=""
  student_two=""
  declare -a names
  files=($(ls students))
  for i in ${files[*]}; do
    read -a arr < "students/$i"
    echo ${arr[0]}
    names+=(${arr[0]})
  done
  while student1=$(yad --list --separator='' --text="Please select student 1" --column "Action" $(echo ${names[*]}) \
  --width=450 --height=350 --print--all); do
    case $student1 in
      *)
        student_one=$student1.student
        break
        ;;
    esac
  done
  while student2=$(yad --list --separator='' --text="Please select student 2" --column "Action" $(echo ${names[*]}) \
  --width=450 --height=350 --print--all); do
    case $student2 in
          *)
            student_two=$student2.student
            answer=$(yad --list --seperator='' --text="Are you sure you \
            want to replace student $student1 with $student2 ?"\
            --column "Action" "Yes" "No" )
            if [[ $answer =~ y|Y|"YES"|"Yes|" ]] ;then
                replace_students
            elif [[ $answer =~ n|N|"No"|"no|" ]] ;then
              yad --info --text="Exiting"
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


student_avg (){
  # opens the file into an array called sarr
  # read -a sarr < $id
  read -a  sarr < "students/$student.student"
  maxcount=${#sarr[*]}
  elenumber=$( expr $maxcount - 2 )
  declare -x avg=0
  if [[ $maxcount -le 1 ]]; then
    yad --info --text="The student $student has no grades" --width 300
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
  yad --info --text="The avarage of student ${sarr[1]} is $TurboAnalIsisAVG points" --width 300
}


Sub_Menu_Student_Avarage (){
  # files lists all student files in the folder
  declare -a names
  files=($(ls students))
  for i in ${files[*]}; do
    read -a arr < "students/$i"
    echo ${arr[0]}
    names+=(${arr[0]})
  done
  while student=$(yad --list --separator='' --text="Please select action" --column "Action" $(echo ${names[*]}) \
  --width=450 --height=350 --print--all); do
    case $student in
      *)
        student_avg
        break
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
  func=$(yad --list --separator='' --text="Please select action" --column "Action"  "Add a student"  "Delete a student" \
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


mainmenu
