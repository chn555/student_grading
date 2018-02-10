#!/bin/bash

replace_students ()
{
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
  exit
}



Sub_Menu_Replace_Student ()
{
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
Sub_Menu_Replace_Student
