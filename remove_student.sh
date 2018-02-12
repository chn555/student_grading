remove_student (){
  files=($(ls students))
  echo ${files[*]}
  #select opt in "${files[@]}" "Stop the script"; do
    # case $opt in
    while student=$(yad --list --text="Please select action" ---column "Action" $(echo ${files[*]}) \
    --width=450 --height=350 --print--all); do
      case $student in
         *.student)
            echo "Student will be removed shortly"
            echo $student
            rm students/$student
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

remove_student
